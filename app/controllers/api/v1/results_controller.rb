# frozen_string_literal: true

module Api
  module V1
    class ResultsController < ApplicationController
      skip_before_action :verify_authenticity_token

      def create
        @exam = params["exam"]
        @exam.each do |exam|
          @count = 0
          @correct = 0
          exam[1]["answers"].each do |answer_choice|
            @count += 1 if answer_choice[1]["status"] == "true"
            @correct += 1 if answer_choice[1]["checked"] == "true"
          end
          @result = Result.find(exam[1]["result_id"].to_i)
          if @count == @correct
            @result.update_attributes(answer_choice: true)
          else
            @result.update_attributes(answer_choice: false)
          end
        end
      end

      private

      def result_params
        params.require(:result).permit(:answer_choice, :exam_id)
      end
    end
  end
end
