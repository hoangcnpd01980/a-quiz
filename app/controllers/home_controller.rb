# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    @categories = Category.newest
  end
end
