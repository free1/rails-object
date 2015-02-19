class UserInfo < ActiveRecord::Base

	belongs_to :user

	validates_presence_of :user
	validates_inclusion_of :gender, in: %w( boy girl secrecy )

end
