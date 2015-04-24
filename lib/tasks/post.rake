# encoding=utf-8
namespace :post do
	desc "抓取内容"
	task :crawl_post => :environment do
		spider = FreeSpider::Begin.new
		spider.plan do
		  site 'http://oszine.com/'
		end
		spider.crawl
	end

	desc "删除不必要内容"
	task :check_content => :environment do
		Post.find_each do |post|
			p '--------begin---------'
			content = post.content.split("<div class=\"loc_link\">\n<ul>\r\n")[0]
			post.update_column(:content, content)
			p content
		end
	end
end