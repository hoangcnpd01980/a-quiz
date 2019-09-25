class ModifyColumnQuestion < ActiveRecord::Migration[5.2]
  def change
    remove_column :questions, :name
    add_column :questions, :question_content, :text
  end
end
