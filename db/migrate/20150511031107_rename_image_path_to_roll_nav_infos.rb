class RenameImagePathToRollNavInfos < ActiveRecord::Migration
  def change
  	rename_column :roll_nav_infos, :image_path, :cover_path
  end
end
