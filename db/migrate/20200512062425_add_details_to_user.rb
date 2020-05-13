class AddDetailsToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :name, :text, null: false
    add_column :users, :role, :integer, null: false#, default: 1
  end
end
