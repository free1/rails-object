# == Schema Information
#
# Table name: article_lists
#
#  id         :integer          not null, primary key
#  article_id :integer
#  content    :text(65535)
#  translate  :text(65535)
#  remark_on  :text(65535)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  periods    :string(255)
#

# 日知文章
class ArticleList < ActiveRecord::Base
	include Commentable

	belongs_to :article
	
	# 验证
	validates_presence_of :article, :content, :translate, :remark_on, :periods
end
