class AddWatchCountToProducts < ActiveRecord::Migration
  def change
    add_column :products, :watch_count, :integer, default: 0
  end
end
