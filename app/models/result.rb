# frozen_string_literal: true

class Result < ApplicationRecord
  belongs_to :exam
  belongs_to :user

  serialize :answers, JSON
end
