class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.integer :sender_id, default: 0
      t.integer :receiver_id
      t.integer :notifiable_id
      t.string :notifiable_type

      t.timestamps null: false
    end
  end
end
