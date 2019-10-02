# frozen_string_literal: true

module Admin
  class CategoriesController < BaseController
    before_action :load_category, only: %i[show update destroy]

    def index
      @categories = Category.includes(:questions).page(params[:page]).per(10)
      @category = Category.new
    end

    def show
      @questions = @category.questions.includes(:answers)
    end

    def create
      @category = current_user.categories.new category_params
      if @category.save
        redirect_to admin_categories_path, success: (t ".success")
      else
        respond_to do |format|
          format.js
        end
      end
    end

    def update
      @category.update category_params
      respond_to do |format|
        format.js
      end
    end

    def destroy
      if @category.questions.any? || @category.exams.any?
        flash[:warning] = t ".warning"
      else
        @category.destroy
        flash[:success] = t ".success"
      end
      redirect_to admin_categories_path
    end

    private

    def category_params
      params.require(:category).permit(:name)
    end

    def load_category
      @category = Category.includes(:questions, :exams).find_by id: params[:id]
      return if @category

      redirect_to admin_categories_path
    end
  end
end
