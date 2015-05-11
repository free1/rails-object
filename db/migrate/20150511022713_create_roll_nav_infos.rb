class CreateRollNavInfos < ActiveRecord::Migration
  def change
    create_table :roll_nav_infos do |t|
      t.string :image_path

      t.timestamps null: false
    end
  end
end
