class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :title
      t.integer :user_id
      t.integer :status, default: 0
      t.text :content

      t.timestamps null: false
    end
  end
end
