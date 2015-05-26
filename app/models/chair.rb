class Chair < ActiveRecord::Base

	belongs_to :user
	# 关注
	has_many :user_collects, as: :listable, dependent: :destroy
	has_many :collected_user, through: :user_collects, source: :listable, source_type: 'Chair'
	# 评论
	has_many :comments, as: :commentable

	# 验证
	validates_presence_of :user, :content, :title
end
