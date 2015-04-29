class UserCollect < ActiveRecord::Base

	belongs_to :user
	belongs_to :listable, polymorphic: true

	validates_uniqueness_of :user_id, scope: [:listable_id, :listable_type]
end
