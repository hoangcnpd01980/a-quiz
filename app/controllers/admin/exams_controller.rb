# frozen_string_literal: true

module Admin
  class ExamsController < BaseController
    def show
      @exam = Exam.find(params[:id])
    end
  end
end
