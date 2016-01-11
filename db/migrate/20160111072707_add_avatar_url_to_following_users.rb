class AddAvatarUrlToFollowingUsers < ActiveRecord::Migration
  def change
    add_column :following_users, :avatar_url, :string
  end
end
