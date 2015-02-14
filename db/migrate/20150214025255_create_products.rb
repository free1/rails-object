class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.text :describe
      t.string :cover_path
      t.string :name

      t.timestamps
    end
  end
end
