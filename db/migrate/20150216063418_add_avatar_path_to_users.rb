class AddAvatarPathToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :avatar_path, :string
  end
end
