# frozen_string_literal: true

class QuestionsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_admin

  def index
    @questions = Question.includes(:answers, :category).page(params[:page]).per(6)
  end

  def new
    @question = Question.new
    2.times { @question.answers.build }
  end

  def create
    @question = current_user.questions.new question_params
    if @question.save
      @questions = Question.includes(:answers, :category).page(params[:page]).per(6)
      flash[:success] = t "messages.success.questions.create"
    else
      flash[:danger] = t "messages.failed.questions.create"
    end
  end

  private

  def question_params
    params.require(:question).permit(:question_content,
                                     :level, :category_id,
                                     answers_attributes: %i[status content _destroy])
  end

  def check_admin
    return if current_user.admin?

    raise ActionController::RoutingError, params[:path]
  end
end
