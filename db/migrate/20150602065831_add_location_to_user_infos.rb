class AddLocationToUserInfos < ActiveRecord::Migration
  def change
    add_column :user_infos, :longitude, :float, default: 0.0
    add_column :user_infos, :latitude, :float, default: 0.0
  end
end
