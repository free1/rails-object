class AddKindToUserCollects < ActiveRecord::Migration
  def change
    add_column :user_collects, :kind, :integer
  end
end
