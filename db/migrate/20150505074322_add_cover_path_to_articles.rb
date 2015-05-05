class AddCoverPathToArticles < ActiveRecord::Migration
  def change
  	add_column :articles, :cover_path, :string
  end
end
