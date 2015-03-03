class CreateProductCategoryShips < ActiveRecord::Migration
  def change
    create_table :product_category_ships do |t|
      t.integer :product_id
      t.integer :category_id

      t.timestamps null: false
    end
  end
end
