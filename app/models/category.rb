# frozen_string_literal: true

class Category < ApplicationRecord
  belongs_to :user
  has_many :exams
  has_many :questions

  validates :name, presence: true, uniqueness: { case_sensitive: false }

  scope :newest, -> { order created_at: :DESC }
end
