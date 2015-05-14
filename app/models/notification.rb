class Notification < ActiveRecord::Base

	# 状态
	enum status: {unread: 0, readed: 1}
end
