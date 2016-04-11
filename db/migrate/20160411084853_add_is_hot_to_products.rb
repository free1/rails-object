class AddIsHotToProducts < ActiveRecord::Migration
  def change
    add_column :products, :is_hot, :boolean, default: false
  end
end
