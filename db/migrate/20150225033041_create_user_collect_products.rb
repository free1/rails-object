class CreateUserCollectProducts < ActiveRecord::Migration
  def change
    create_table :user_collect_products do |t|
      t.integer :product_id
      t.integer :user_id

      t.timestamps null: false
    end

    add_index :user_collect_products, :product_id
    add_index :user_collect_products, :user_id
    add_index :user_collect_products, [:product_id, :user_id], unique: true
  end
end
