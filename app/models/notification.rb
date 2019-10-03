# frozen_string_literal: true

class Notification < ApplicationRecord
  belongs_to :user
  belongs_to :question

  scope :shows, ->(id) { where(user_id: id).order(created_at: :desc) }

  enum notification_content: %i[created_new_question updated_question]
  enum notification_status: %i[not_seen seen]
end
