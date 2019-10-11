class RemoveColumAnsewerIdIntoResult < ActiveRecord::Migration[5.2]
  def self.up
    remove_column :results, :answer_id
    add_column :results, :answer_choice, :boolean
  end

  def self.down
    add_reference :results, :answer, foreign_key: true
    remove_column :results, :answer_choice
  end
end
