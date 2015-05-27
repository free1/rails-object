class Notification < ActiveRecord::Base

	belongs_to :sender_user, foreign_key: 'sender_id', class_name: 'User'
	belongs_to :receiver_user, foreign_key: 'receiver_id', class_name: 'User'
	belongs_to :notifiable, polymorphic: true

	scope :recent, -> { order(created_at: :desc) }

	# 状态
	enum status: {unread: 0, readed: 1}

	def select_content
		case self.content
		when 'comment'
			'评论了你的文章'
		end
	end
end
