class CreateUserTagShips < ActiveRecord::Migration
  def change
    create_table :user_tag_ships do |t|
      t.integer :user_id
      t.integer :tag_id

      t.timestamps null: false
    end
  end
end
