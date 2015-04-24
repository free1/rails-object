require 'free_spider'

class Post < ActiveRecord::Base

	belongs_to :user
	validates :title, presence: true, uniqueness: true
	validates :content, presence: true

	class << self
		# 抓取内容
		def crawl_post
			spider = FreeSpider::Begin.new
			spider.plan do
			  site 'http://oszine.com/'
			end
			spider.crawl
		end
		# 删除不必要内容
		def check_content
			Post.find_each do |post|
				content = post.content.split("<div class=\"loc_link\">\n<ul>\r\n")[0]
				post.update_column(:content, content)
			end
		end

	end
	
end
