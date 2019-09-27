class CreateCrawlerAnswers < ActiveRecord::Migration[5.2]
  def change
    create_table :crawler_answers do |t|
      t.references :crawler_question
      t.text :content
      t.boolean :status

      t.timestamps
    end
  end
end
