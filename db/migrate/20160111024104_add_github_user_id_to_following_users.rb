class AddGithubUserIdToFollowingUsers < ActiveRecord::Migration
  def change
    add_column :following_users, :github_user_id, :integer
  end
end
