require 'free_spider'

class Post < ActiveRecord::Base

	belongs_to :user
	validates :title, presence: true, uniqueness: true
	validates :content, presence: true

	def self.crawl_post
		spider = FreeSpider::Begin.new
		spider.plan do
		  site 'http://oszine.com/'
		end
		spider.crawl
	end
	
end
