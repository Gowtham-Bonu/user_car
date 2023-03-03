class CreateCars < ActiveRecord::Migration[7.0]
  def change
    create_table :cars do |t|
      t.string :name
      t.integer :price
      t.string :brand
      t.string :color
      t.boolean :remember_brand
      t.timestamps
    end
  end
end
