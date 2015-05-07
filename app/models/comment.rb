class Comment < ActiveRecord::Base
	include TextCheck
	
	belongs_to :user
	belongs_to :commentable, polymorphic: true

	validates_presence_of :content, :commentable_id, :commentable_type, :user_id

end
