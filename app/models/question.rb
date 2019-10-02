# frozen_string_literal: true

class Question < ApplicationRecord
  belongs_to :category
  has_many :answers, dependent: :destroy
  has_many :results
  belongs_to :user

  after_create_commit :show_question

  accepts_nested_attributes_for :answers, allow_destroy: true, reject_if: :all_blank
  validates :level, presence: true
  validates :question_content, presence: true, length: { minimum: 5, maximum: 255 }
  validate :valid_answer, :valid_correct, :count_answer, :question_exist
  enum level: %i[easy hard]

  def self.getquestion(exam)
    hard = exam.master? ? 10 : 5
    questions = includes(:category).where(level: "hard", category_id: exam.category_id).sample(hard)
    questions += includes(:category).where(level: "easy", category_id: exam.category_id).sample(20 - hard)
    questions.shuffle
  end

  def convert_attributes(crawler_question)
    self.question_content = crawler_question.question_content
    self.level = crawler_question.level
    crawler_question.crawler_answers.each { |answer| answers.new content: answer.content, status: answer.status }
  end

  private

  def valid_correct
    correct = answers.select(&:status).size
    errors.add(:base, I18n.t("model.question.no_correct")) if correct.zero?
    errors.add(:base, I18n.t("model.question.no_wrong")) if correct == answers.size
  end

  def count_answer
    errors.add(:base, I18n.t("model.question.less_than")) if answers.size < 2
  end

  def valid_answer
    answer = answers.collect { |a| a.content.downcase }
    errors.add(:base, I18n.t("model.question.not_same")) unless answer.uniq.size == answer.size
  end

  def question_exist
    questions = Question.joins(:answers).where(question_content: question_content,
      category_id: category_id, level: level,
      answers: { content: answers.map { |answer| answer.content.downcase } })
    errors.add(:base, I18n.t("model.question.exist")) if questions.present?
  end

  def show_question
    QuestionBroadcastJob.perform_later
  end
end
