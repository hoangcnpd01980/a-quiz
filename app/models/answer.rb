# frozen_string_literal: true

class Answer < ApplicationRecord
  belongs_to :question, optional: true
  has_many :results

  validates :content, presence: true, length: { minimum: 1, maximum: 255 }
end
