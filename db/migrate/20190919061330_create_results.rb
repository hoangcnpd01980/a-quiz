class CreateResults < ActiveRecord::Migration[5.2]
  def change
    create_table :results do |t|
      t.references :answer
      t.references :user
      t.references :exam
      t.string :question_content
      t.text :answers

      t.timestamps
    end
  end
end
