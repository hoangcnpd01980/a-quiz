# frozen_string_literal: true

module Api
  module V1
    class ExamsController < ApplicationController
      before_action :load_exam, only: %i[show destroy update edit]
      before_action :authenticate_user!

      def index
        @exams = current_user.exams.map do |exam|
          { id: exam.id, difficulity: exam.difficulity,
            questions_count: exam.results.count, category_id: exam.category_id, results: exam.results.map { |result| {answer_choice: result.answer_choice}}}
        end
        render json: @exams
      end

      def create
        @exam = current_user.exams.create(exam_params)
        questions = Question.getquestion(@exam)
        values = questions.map { |question| { user_id: current_user.id, exam_id: @exam.id, question_content: question.question_content,  answers: question.answers.map { |e| { content: e.content, status: e.status } } } }
        Result.import values
        render json: @exam.as_json.merge("questions_count" => questions.length, results: @exam.results.map { |result| {answer_choice: result.answer_choice}})
      end

      def show
        @results = @exam.results.map do |q|
          { result_id: q.id, exam_id: q.exam_id, question_content: q.question_content,
            answers: q.answers.map { |a| { content: a["content"], status: a["status"], checked: false } }, answer_choice: q.answer_choice }
        end
        render json: @results
      end

      def destroy
        @exam.destroy
        render json: @exam
      end

      private

      def load_exam
        @exam = Exam.find(params[:id])
      end

      def exam_params
        params.require(:exam).permit(:user_id, :difficulity, :category_id)
      end
    end
  end
end
