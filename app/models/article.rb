# == Schema Information
#
# Table name: articles
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  user_id    :integer
#  status     :integer          default(0)
#  content    :text(65535)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  cover_path :string(255)
#  author     :string(255)
#

# 日知栏目
class Article < ActiveRecord::Base
	belongs_to :user
	# 关注
	has_many :user_collects, as: :listable, dependent: :destroy
	# has_many :collected_user, through: :user_collects, source: :listable, source_type: 'Article'
	# 文章期刊
	has_many :article_lists, dependent: :destroy

	# 状态
	enum status: {updating: 0, finished: 1}

	# 验证
	validates_presence_of :user
	validates :title, presence: true, length: { maximum: 30 }
	validates :content, presence: true, length: { maximum: 5000 }
end
