class UserObserver < ActiveRecord::Observer
	observe :user

	def after_create(record)
		record.create_info
		record.create_wechat_info
	end
end