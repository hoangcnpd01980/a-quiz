# frozen_string_literal: true

class Answer < ApplicationRecord
  belongs_to :question, optional: true
  has_many :results

  before_save :downcase_content

  validates :content, presence: true, length: { minimum: 1, maximum: 255 }

  def downcase_content
    content.downcase!
  end
end
