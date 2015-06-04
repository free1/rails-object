class AddCoverPathToPosts < ActiveRecord::Migration
  def change
  	add_column :posts, :cover_path, :string
  end
end
