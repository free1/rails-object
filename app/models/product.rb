class Product < ActiveRecord::Base

	belongs_to :user
	has_many :user_collect_products, dependent: :destroy
	has_many :collected_user, through: :user_collect_products, source: :user

	validates_presence_of :user, :cover_path
	validates :title, presence: true, length: { maximum: 30 }
	validates :describe, presence: true, length: { maximum: 500 }
	
end
