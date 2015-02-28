class AddUserIdToWechatInfos < ActiveRecord::Migration
  def change
    add_column :wechat_infos, :user_id, :integer
  end
end
