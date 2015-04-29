require 'free_spider'

class Post < ActiveRecord::Base
	include Redis::Objects
	counter :show_count
	set :score_post, global: true

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

			spider1 = FreeSpider::Begin.new
			spider1.plan do
			  site 'http://www.mr-wu.cn/'
			end
			spider1.crawl
		end
		# 删除不必要内容
		def check_content
			Post.find_each do |post|
				content = post.content.split("<div class=\"loc_link\">\n<ul>\r\n")[0]
				post.update_column(:content, content)
			end
		end

		# 计算查看数量
		def add_watch_count(id)
			post = Post.find(id)
			post.show_count.incr
			score_post << id
		end
		def sum_watch_count
			score_post.each do |post_id|
				post = Post.find(post_id)
				post.watch_count = post.show_count
				if post.save
					score_post.delete(post_id)
					post.show_count.decr
				end
			end
		end

	end
	
end
