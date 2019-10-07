# frozen_string_literal: true

module Admin
  class CrawlerAnswersController < BaseController
    before_action :load_crawler_answer, only: %i[update destroy]

    def create
      @crawler_answer = CrawlerAnswer.new crawler_answer_params
      @crawler_answer.save
      respond_to do |format|
        format.js
      end
    end

    def update
      @crawler_answer.update crawler_answer_params
      respond_to do |format|
        format.js
      end
    end

    def destroy
      @crawler_answer.destroy
      respond_to do |format|
        format.js
      end
    end

    private

    def crawler_answer_params
      params.require(:crawler_answer).permit(:content, :status, :crawler_question_id)
    end

    def load_crawler_answer
      @crawler_answer = CrawlerAnswer.find_by id: params[:id]
      return if @crawler_answer

      redirect_to admin_dashboard_path
    end
  end
end
