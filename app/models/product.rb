class Product < ActiveRecord::Base

	belongs_to :user

	validates_presence_of :user
	validates :title, length: { maximum: 30 }
	validates :describe, length: { maximum: 500 }

end
