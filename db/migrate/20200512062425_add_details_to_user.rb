class AddDetailsToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :name, :string, null: false
    add_column :users, :phone, :integer
    add_column :users, :role, :integer, null: false, default: :CommunityUser
  end
end
