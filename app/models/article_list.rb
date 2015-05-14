# 日知文章
class ArticleList < ActiveRecord::Base

	belongs_to :article
	# 评论
	has_many :comments, as: :commentable
	
	# 验证
	validates_presence_of :article, :content, :translate, :remark_on, :periods
end
