class CreateCrawlerQuestions < ActiveRecord::Migration[5.2]
  def change
    create_table :crawler_questions do |t|
      t.string :question_content
      t.integer :level, default: 0

      t.timestamps
    end
  end
end
