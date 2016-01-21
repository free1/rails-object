class ChangeIsSinceValueEqIsFollowingToFollowingUsers < ActiveRecord::Migration
  def change
    execute "UPDATE following_users SET is_since = is_following"
  end
end
