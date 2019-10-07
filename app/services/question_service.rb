# frozen_string_literal: true

class QuestionService
  class << self
    def import(user, params, crawler_questions)
      crawler_questions.each do |crawler_question|
        ActiveRecord::Base.transaction do
          question = user.questions.new category_id: params[:category]
          question.convert_attributes(crawler_question)
          question.save
          crawler_question.really_destroy!
          import_notification(question)
        end
      end
    rescue StandardError
      false
    end

    def import_notification(question)
      Notification.import!(%i[user_id question_id notification_content],
                           User.admin.ids.map { |id| [id, question.id, 0] })
    end
  end
end
