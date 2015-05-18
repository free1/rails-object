class UserCollectProduct < ActiveRecord::Base

	belongs_to :user
	belongs_to :product, counter_cache: true
	
end
