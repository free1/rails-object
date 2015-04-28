class CreateUserCollects < ActiveRecord::Migration
  def change
    create_table :user_collects do |t|
      t.integer :user_id
      t.integer :listable_id
      t.string :listable_type

      t.timestamps null: false
    end

    add_index :user_collects, :user_id
    add_index :user_collects, :listable_id
    add_index :user_collects, [:listable_id, :listable_type], length: {listable_id: 4, listable_type: 100}
  end
end
