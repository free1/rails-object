class AddIndexToColumns < ActiveRecord::Migration
  def change
  	add_index :comments, :user_id
  	add_index :product_category_ships, [:product_id, :category_id], unique: true
  	add_index :product_category_ships, :product_id
  	add_index :product_category_ships, :category_id
  	add_index :products, :user_id
  	add_index :user_infos, :user_id
  	add_index :user_tag_ships, :user_id
  	add_index :user_tag_ships, :tag_id
  	add_index :user_tag_ships, [:user_id, :tag_id], unique: true
  	add_index :wechat_infos, :user_id
  end
end
