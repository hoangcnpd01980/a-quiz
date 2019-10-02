# frozen_string_literal: true

class QuestionBroadcastJob < ApplicationJob
  queue_as :default

  def perform
    ActionCable.server.broadcast "question_channel", status: "Success"
  end
end
