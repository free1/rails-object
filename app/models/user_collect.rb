class UserCollect < ActiveRecord::Base

	belongs_to :user
	belongs_to :listable, polymorphic: true
end
