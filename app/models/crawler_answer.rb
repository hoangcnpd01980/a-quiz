# frozen_string_literal: true

class CrawlerAnswer < ApplicationRecord
  belongs_to :crawler_question

  validates :content, presence: true
end
