# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  add_flash_types :success, :danger, :warning, :info

  rescue_from ActionController::RoutingError do
    render file: "#{Rails.root}/public/404", layout: false, status: :not_found
  end
end
