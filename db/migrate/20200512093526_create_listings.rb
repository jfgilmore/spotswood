class CreateListings < ActiveRecord::Migration[6.0]
  def change
    create_table :listings do |t|
      t.string :name, null: false
      t.datetime :time, null: false
      t.string :location, null: false
      t.string :why
      t.integer :cost, default: 0
      t.string :summary, null: false
      t.text :description
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
