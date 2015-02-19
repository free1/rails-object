class CreateUserInfos < ActiveRecord::Migration
  def change
    create_table :user_infos do |t|
      t.integer :user_id
      t.string :gender
      t.text :resume
      t.string :website

      t.timestamps
    end
  end
end
