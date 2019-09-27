class AddDeletedAtToCrawlerQuestions < ActiveRecord::Migration[5.2]
  def change
    add_column :crawler_questions, :deleted_at, :datetime
    add_index :crawler_questions, :deleted_at
  end
end
