class Product < ActiveRecord::Base

	belongs_to :user

	validates_presence_of :user, :cover_path
	validates :title, presence: true, length: { maximum: 30 }
	validates :describe, presence: true, length: { maximum: 500 }
	
end
