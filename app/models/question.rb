# frozen_string_literal: true

class Question < ApplicationRecord
  belongs_to :category
  has_many :answers, dependent: :destroy
  has_many :results
  belongs_to :user

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

  private

  def valid_correct
    correct = answers.select(&:status).size
    return errors.add(:base, I18n.t("model.question.no_correct")) if correct.zero?
    return errors.add(:base, I18n.t("model.question.no_wrong")) if correct == answers.size
  end

  def count_answer
    return errors.add(:base, I18n.t("model.question.less_than")) if answers.size < 2
  end

  def valid_answer
    answer = answers.collect(&:content)
    return errors.add(:base, I18n.t("model.question.not_same")) unless answer.uniq.size == answer.size
  end

  def find_question
    Question.find_by(question_content: question_content, category_id: category_id, level: level)
  end

  def question_exist
    return if find_question.blank?

    question_exist = find_question.answers.collect(&:content)
    errors.add(:base, I18n.t("model.question.exist")) if (answers.collect(&:content) - question_exist).size.zero?
  end
end
