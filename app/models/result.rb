# frozen_string_literal: true

class Result < ApplicationRecord
  belongs_to :answer, optional: true
  belongs_to :exam
  belongs_to :question

  validates :question_id, uniqueness: true
end
