# frozen_string_literal: true

class CrawlerAnswer < ApplicationRecord
  belongs_to :crawler_question
end
