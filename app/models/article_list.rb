class ArticleList < ActiveRecord::Base

	belongs_to :article
	# 评论
	has_many :comments, as: :commentable
	
end
