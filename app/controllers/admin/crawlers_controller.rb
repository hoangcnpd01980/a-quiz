# frozen_string_literal: true

module Admin
  class CrawlersController < BaseController
    before_action :load_crawler_questions, only: %i[destroy]

    def destroy
      ActiveRecord::Base.transaction do
        @crawler_questions.destroy_all
        redirect_to admin_crawler_questions_path, success: t(".success")
      end
    rescue StandardError
      redirect_to admin_crawler_questions_path, danger: t(".danger")
    end

    private

    def load_crawler_questions
      @crawler_questions = CrawlerQuestion.where(id: params[:ids])
      return if @crawler_questions

      redirect_to admin_dashboard_path
    end
  end
end
