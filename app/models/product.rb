class Product < ActiveRecord::Base

	belongs_to :user
	# 收藏
	has_many :user_collect_products, dependent: :destroy
	has_many :collected_user, through: :user_collect_products, source: :user
	# 分类
	has_many :product_category_ships, dependent: :destroy
	has_many :categories, through: :product_category_ships

	validates_presence_of :user, :cover_path
	validates :title, presence: true, length: { maximum: 30 }
	validates :describe, presence: true, length: { maximum: 500 }


	def cover_path_with_size
		"#{self.cover_path}?imageView2/1/w/330/h/200"
	end
	
end
