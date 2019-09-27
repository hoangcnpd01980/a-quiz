# frozen_string_literal: true

module Api
  module V1
    class ExamsController < ApplicationController
      def index
        @exams = Exam.all.map { |exam| { id: exam.id, difficulity: exam.difficulity, questions_count: exam.results.count } }
        render json: @exams
      end

      def create
        @exam = current_user.exams.create(exam_params)
        questions = list_question(@exam)
        values = questions.map { |question| { exam_id: @exam.id, question_id: question.id } }
        Result.import values
        render json: @exam.as_json.merge("questions_count" => questions.length)
      end

      def show
        @exam = Exam.find(params[:id])
        @exams = @exam.questions
        render json: @exams
      end

      private

      def list_question(exam)
        difficulity = exam.master? ? 10 : 5
        Question.getquestion(:hard, exam.category_id, difficulity) + Question.getquestion(:easy, exam.category_id, 20 - difficulity)
      end

      def exam_params
        params.require(:exam).permit(:difficulity, :category_id)
      end
    end
  end
end
