# frozen_string_literal: true

require_relative "environment"
set :environment, Rails.env

every :day, at: "10:20am" do
  runner "Crawler.new.run"
end
