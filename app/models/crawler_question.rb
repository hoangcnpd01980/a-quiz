# frozen_string_literal: true

class CrawlerQuestion < ApplicationRecord
  has_many :crawler_answers

  enum level: %i[easy hard]
end
