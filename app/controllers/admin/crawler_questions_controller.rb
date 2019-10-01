# frozen_string_literal: true

module Admin
  class CrawlerQuestionsController < BaseController
    before_action :load_crawler_question, only: %i[create destroy]

    def index
      @crawler_questions = CrawlerQuestion.includes(:crawler_answers).page(params[:page]).per(10)
    end

    def create
      @question = current_user.questions.new category_id: params[:category]
      @question.convert_attributes(@crawler_question)
      if @question.save
        @crawler_question.really_destroy!
        redirect_to admin_crawler_questions_path, success: (t ".success")
      else
        respond_to do |format|
          format.js
        end
      end
    end

    def destroy
      @crawler_question.destroy
      redirect_to admin_crawler_questions_path, success: (t ".success")
    end

    private

    def load_crawler_question
      @crawler_question = CrawlerQuestion.find_by id: params[:id]
      return if @crawler_question

      redirect_to admin_dashboard_path
    end
  end
end
