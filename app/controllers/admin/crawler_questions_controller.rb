# frozen_string_literal: true

module Admin
  class CrawlerQuestionsController < BaseController
    before_action :load_crawler_question, only: %i[create update destroy]

    def index
      @crawler_questions = CrawlerQuestion.includes(:crawler_answers).page(params[:page]).per(10)
    end

    def create
      @question = current_user.questions.new category_id: params[:category]
      @question.convert_attributes(@crawler_question)
      ActiveRecord::Base.transaction do
        @question.save!
        notification(@question, @crawler_question)
        redirect_to admin_crawler_questions_path, success: (t ".success")
      end
    rescue StandardError
      respond_to do |format|
        format.js
      end
    end

    def update
      @crawler_question.update crawler_question_params
      respond_to do |format|
        format.js
      end
    end

    def destroy
      @crawler_question.destroy
      redirect_to admin_crawler_questions_path, success: (t ".success")
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

    def notification(question, crawler_question)
      crawler_question.really_destroy!
      Notification.import!(%i[user_id question_id notification_content],
                           User.admin.ids.map { |id| [id, question.id, 0] })
    end
  end
end
