class AddIsEmailPushToUsers < ActiveRecord::Migration
  def change
    add_column :users, :is_email_push, :boolean, default: true
  end
end
