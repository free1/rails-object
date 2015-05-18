class Notification < ActiveRecord::Base

	belongs_to :user

	# 状态
	enum status: {unread: 0, readed: 1}

	def self.select_content(type)
		case type
		when 'comment'
			'有人评论了你的文章'
		end
	end
end
