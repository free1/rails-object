class AddUserCollectProductsCount < ActiveRecord::Migration
  def change
  	add_column :products, :user_collect_products_count, :integer, default: 0
  end
end
