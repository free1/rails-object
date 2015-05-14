class AddIndexToNotifications < ActiveRecord::Migration
  def change
  	add_index :notifications, :sender_id
  	add_index :notifications, :receiver_id
  	add_index :notifications, :notifiable_id
  	add_index :notifications, :notifiable_type
  	add_index :notifications, [:notifiable_id, :notifiable_type], length: {notifiable_id: 4, notifiable_type: 100}
  end
end
