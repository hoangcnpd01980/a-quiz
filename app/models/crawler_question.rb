# frozen_string_literal: true

class CrawlerQuestion < ApplicationRecord
  acts_as_paranoid

  has_many :crawler_answers, dependent: :destroy

  enum level: %i[easy hard]
end
