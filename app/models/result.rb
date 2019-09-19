# frozen_string_literal: true

class Result < ApplicationRecord
  belongs_to :answer
  belongs_to :exam
  belongs_to :question
end
