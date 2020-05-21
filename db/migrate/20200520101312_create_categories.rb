class CreateCategories < ActiveRecord::Migration[6.0]
  def change
    create_table :categories do |t|
      t.string :name, null: false
      t.string :description

      t.timestamps
    end

    add_column :listings, :category_id, :integer, null: false

    # Adding some indexes to improve search efficiency for anticipated regular
    # queries and filters
    add_index :listings, :at_time
    add_index :listings, :name
    add_index :listings, :summary
    add_index :listings, :location
    add_index :listings, :category_id
  end
end
