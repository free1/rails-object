# == Schema Information
#
# Table name: products
#
#  id                          :integer          not null, primary key
#  describe                    :text(65535)
#  cover_path                  :string(255)
#  title                       :string(255)
#  created_at                  :datetime
#  updated_at                  :datetime
#  user_id                     :integer
#  user_collect_products_count :integer          default(0)
#

class Product < ActiveRecord::Base
	# include Obfuscate
	include Commentable

	# 发布人
	belongs_to :user
	# 收藏
	has_many :user_collect_products, dependent: :destroy
	# has_many :collected_user, through: :user_collect_products, source: :user
	# 分类
	has_many :product_category_ships, dependent: :destroy
	has_many :categories, through: :product_category_ships

	# 验证
	validates_presence_of :user, :cover_path
	validates :title, presence: true, length: { maximum: 30 }
	validates :describe, presence: true, length: 300..8000
	
	# 排序
	scope :category_for, ->(category_name) { joins(:categories).where("categories.name = ?", category_name)}

	def cover_path_with_size(width, height)
		"#{self.cover_path}?imageView2/1/w/#{width}/h/#{height}"
	end

	# def to_param
 #    encrypt id
 #  end
	
end
