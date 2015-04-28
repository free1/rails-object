class Article < ActiveRecord::Base
	belongs_to :user
	# 关注
	has_many :user_collects, as: :listable, dependent: :destroy
	has_many :collected_user, through: :user_collects, source: :listable, source_type: 'Article'

	# 状态
	enum status: {updating: 0, publish: 1, finished: 2}

	# 验证
	validates_presence_of :user
	validates :title, presence: true, length: { maximum: 30 }
	validates :content, presence: true, length: { maximum: 5000 }
end
