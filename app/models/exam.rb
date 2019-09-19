# frozen_string_literal: true

class Exam < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_many :results

  enum difficulity: %i[amateur master]
end
