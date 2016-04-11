class AddStatusToProducts < ActiveRecord::Migration
  def change
    add_column :products, :status, :integer, default: 1
  end
end
