class AddIsSinceToFollowingUsers < ActiveRecord::Migration
  def change
    add_column :following_users, :is_since, :boolean, default: false
  end
end
