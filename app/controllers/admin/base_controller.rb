# frozen_string_literal: true

module Admin
  class BaseController < ApplicationController
    layout "admin"
    before_action :limit_access
  end
end
