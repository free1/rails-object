# encoding=utf-8
namespace :post do
	desc "抓取oszine内容"
	task :crawl_oszine_post => :environment do
		spider = FreeSpider::Begin.new
		spider.plan do
		  site 'http://oszine.com/'
		end
		spider.crawl
	end

	desc "抓取ingchuang内容"
	task :crawl_ingchuang_post => :environment do
		spider = FreeSpider::Begin.new
		spider.plan do
		  site 'http://www.ingchuang.com/'
		end
		spider.crawl
	end

	desc "抓取mrwu内容"
	task :crawl_mrwu_post => :environment do
		spider = FreeSpider::Begin.new
		spider.plan do
		  site 'http://www.mr-wu.cn/'
		end
		spider.crawl
	end

	desc "删除不必要内容"
	task :check_content => :environment do
		p '--------begin---------'
		Post.find_each do |post|
			content = post.content.split("<div class=\"loc_link\">\n<ul>\r\n")[0]
			post.update_column(:content, content)
			p content
		end
	end

	desc "之前抓取到的文章加上封面"
	task :add_cover_path => :environment do
		p '--------begin---------'
		Post.find_each do |post|
			doc = Nokogiri::HTML(post.content)
			image_path = doc.css('img').first
			if image_path.present?
				post.update_column(:cover_path, image_path["src"])
			end
		end
	end

	desc "删除短文章"
	task :delete_short_post => :environment do
		p '--------begin---------'
		Post.find_each do |post|
			if post.content.size < 100
				post.delete
				p '--------delete success---------'
			end
		end
	end
end