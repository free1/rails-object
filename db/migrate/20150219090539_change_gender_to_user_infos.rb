class ChangeGenderToUserInfos < ActiveRecord::Migration
  def change
  	change_column_default :user_infos, :gender, 'secrecy'
  end
end
