class AddWeightToRollNavInfos < ActiveRecord::Migration
  def change
  	add_column :roll_nav_infos, :weight, :integer, default: 0
  end
end
