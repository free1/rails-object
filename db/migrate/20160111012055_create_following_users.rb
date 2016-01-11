class CreateFollowingUsers < ActiveRecord::Migration
  def change
    create_table :following_users do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
