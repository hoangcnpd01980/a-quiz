class CreateQuestions < ActiveRecord::Migration[5.2]
  def change
    create_table :questions do |t|
      t.references :category
      t.string :name
      t.integer :level
      t.boolean :multi

      t.timestamps
    end
  end
end
