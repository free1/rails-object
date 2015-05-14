class Notification < ActiveRecord::Base

	belongs_to :user

	# 状态
	enum status: {unread: 0, readed: 1}
end
