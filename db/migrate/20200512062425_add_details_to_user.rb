class AddDetailsToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :name, :text, null: false, default: ""
    add_column :users, :phone, :integer
    add_column :users, :role, :integer, default: :Guest
  end
end
