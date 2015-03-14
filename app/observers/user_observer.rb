class UserObserver < ActiveRecord::Observer
	observe :user

	# 创建用户详细信息
	def after_create(record)
		record.create_info
		record.create_wechat_info
	end
end