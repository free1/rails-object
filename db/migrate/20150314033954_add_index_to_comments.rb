class AddIndexToComments < ActiveRecord::Migration
  def change
  	add_index :comments, [:commentable_id, :commentable_type], length: {commentable_id: 4, commentable_type: 100}
  end
end
