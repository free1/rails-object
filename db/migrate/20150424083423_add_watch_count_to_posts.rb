class AddWatchCountToPosts < ActiveRecord::Migration
  def change
  	add_column :posts, :watch_count, :integer, default: 0
  end
end
