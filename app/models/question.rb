# frozen_string_literal: true

class Question < ApplicationRecord
  belongs_to :category
  has_many :answers
  has_many :results

  enum level: %i[easy hard]
end
