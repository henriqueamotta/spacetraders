class CreateProducts < ActiveRecord::Migration[7.1]
  def change
    create_table :products do |t|
      t.string :name
      t.string :model
      t.integer :passengers
      t.integer :crew
      t.float :length
      t.float :fuel_capacity
      t.float :cargo_capacity
      t.decimal :price
      t.string :manufacturer
      t.string :terrain
      t.text :overview
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
