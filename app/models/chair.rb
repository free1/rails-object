class Chair < ActiveRecord::Base

	belongs_to :user

	# 验证
	validates_presence_of :user, :content, :title
end
