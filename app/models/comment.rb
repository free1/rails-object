# == Schema Information
#
# Table name: comments
#
#  id               :integer          not null, primary key
#  content          :text(65535)
#  commentable_id   :integer
#  commentable_type :string(255)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  user_id          :integer
#  content_html     :text(65535)
#

class Comment < ActiveRecord::Base
	include TextCheck
	include PublicActivity::Common
	
	belongs_to :user
	belongs_to :commentable, polymorphic: true

	validates_presence_of :content, :commentable_id, :commentable_type, :user_id

end
