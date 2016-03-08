class AddAttrToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :product_id, :integer
    add_column :orders, :quantity, :integer, default: 1
  end
end
