class CreateListings < ActiveRecord::Migration[6.0]
  def change
    create_table :listings do |t|
      t.text :name, null: false
      t.datetime :time
      t.text :location
      t.text :why
      t.integer :cost, default: 0
      t.text :summary, null: false
      t.text :description
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
