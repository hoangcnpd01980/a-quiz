class RemoveMultiFromQuestions < ActiveRecord::Migration[5.2]
  def change
    remove_column :questions, :multi
  end
end
