class CreateArticleLists < ActiveRecord::Migration
  def change
    create_table :article_lists do |t|
      t.integer :article_id
      t.text :content
      t.text :translate
      t.text :remark_on

      t.timestamps null: false
    end
  end
end
