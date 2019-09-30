# frozen_string_literal: true

module Api
  module V1
    class ExamsController < ApplicationController
      before_action :load_exam, only: %i[show destroy]
      before_action :authenticate_user!

      def index
        @exams = current_user.exams.map { |exam| { id: exam.id, difficulity: exam.difficulity, questions_count: exam.results.count } }
        render json: @exams
      end

      def create
        @exam = current_user.exams.create(exam_params)
        questions = Question.getquestion(@exam)
        values = questions.map { |question| { exam_id: @exam.id, question_id: question.id } }
        Result.import values
        render json: @exam.as_json.merge("questions_count" => questions.length)
      end

      def show
        @questions = @exam.questions
        render json: @questions
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
        params.require(:exam).permit(:difficulity, :category_id)
      end
    end
  end
end
