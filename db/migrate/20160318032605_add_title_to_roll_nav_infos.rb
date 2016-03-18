class AddTitleToRollNavInfos < ActiveRecord::Migration
  def change
    add_column :roll_nav_infos, :title, :string
  end
end
