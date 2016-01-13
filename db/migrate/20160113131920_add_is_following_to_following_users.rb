class AddIsFollowingToFollowingUsers < ActiveRecord::Migration
  def change
    add_column :following_users, :is_following, :boolean, default: false
  end
end
