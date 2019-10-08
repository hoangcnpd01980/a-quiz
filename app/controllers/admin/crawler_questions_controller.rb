# frozen_string_literal: true

module Admin
  class CrawlerQuestionsController < BaseController
    before_action :load_crawler_question, only: %i[update destroy]

    def index
      @crawler_questions = CrawlerQuestion.newest.includes(:crawler_answers).page(params[:page]).per(10)
    end

    def create
      Crawler.new.delay(queue: :crawler).run
      redirect_to admin_crawler_questions_path, success: t(".success")
    end

    def update
      @crawler_question.update crawler_question_params
      respond_to do |format|
        format.js
      end
    end

    def destroy
      @crawler_question.destroy
      redirect_to admin_crawler_questions_path, success: t(".success")
    end

    private

    def crawler_question_params
      params.require(:crawler_question).permit(:question_content, :level)
    end

    def load_crawler_question
      @crawler_question = CrawlerQuestion.find_by id: params[:id]
      return if @crawler_question

      redirect_to admin_dashboard_path
    end
  end
end
