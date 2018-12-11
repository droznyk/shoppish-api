class CreateOrderPositions < ActiveRecord::Migration[5.2]
  def change
    create_table :order_positions do |t|
      t.references :order, foreign_key: true
      t.references :product, foreign_key: true
      t.integer :product_quantity
      t.float :price

      t.timestamps
    end
  end
end
