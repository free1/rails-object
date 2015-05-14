class AddStatusToNotifications < ActiveRecord::Migration
  def change
  	add_column :notifications, :status, :integer, default: 0
  	add_column :notifications, :content, :text
  end
end
