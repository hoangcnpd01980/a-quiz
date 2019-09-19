class CreateExams < ActiveRecord::Migration[5.2]
  def change
    create_table :exams do |t|
      t.references :user
      t.references :category
      t.integer :difficulity
      t.datetime :start_time
      t.datetime :end_time

      t.timestamps
    end
  end
end
