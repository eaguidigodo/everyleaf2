class AddContrainst < ActiveRecord::Migration[5.2]
  def change
    change_column :tasks, :name, :string, null: false
    change_column :tasks, :detail, :text, null: false
    add_index :tasks, :name, :unique => true
  end
end
