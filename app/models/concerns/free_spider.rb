# encoding=utf-8
# 内容抓取
require 'open-uri'
require 'nokogiri'

# 程序入口
# require 'free_spider'
# spider = FreeSpider::Begin.new
# spider.plan do
#   site 'http://oszine.com/'
# end
# spider.crawl

module FreeSpider
	class Begin

		def initialize
      # 找到的链接
      @todo = []
      # 已经访问过的链接
      @visited = []
      # 暂时存放内容
      @news_teaching_content = {}
      # 文章题目(判断是否重复)
      @title_saved = []
   	end

    # 程序制定函数，用户选择需要抓取的网页内容
    def plan(&block)
      if block_given?
        instance_eval(&block)
      else
        puts "no plan"
      end
    end

    def find_link(path)
      puts "--------find_link--------"
      begin
        crawl if path == nil
        html = open(path).read
        # html = open('http://www.dfrobot.com.cn/').read
        # 访问过的链接放入数组
        @visited << path
        # p "================"
        # p @visited
        # p path
        doc = Nokogiri::HTML(html)
        # 抓取链接加入爬取队列
        doc.css("a").map do |href|
          # 选取内容
          # title = href.attributes["title"]
          # title_content = href.attributes["title"].value unless title.nil?
          # 处理链接
          href = href.attributes["href"].value unless href.attributes["href"].nil?
          # 去除重复链接
          href = @site + href unless href.include?("#{@site}")

          # 加入爬取队列
          @todo << href
        end

        # 抓取主要内容
        unless doc.at_css(".entry-content").nil?
          entry_title = doc.css(".entry-title").children.to_html
          unless @title_saved.include?(entry_title)
            @title_saved << entry_title
            content = doc.css(".entry-content").children.to_html
            @news_teaching_content = {title: entry_title, content: content, source_site: @site}

            # # 文章题目
            # doc.css(".entry-title").each do |entry_title|
            #   title = entry_title.children.to_html unless entry_title.nil?
            #   news_teaching_content_tmp = {title: title}
            # end
            # # 放入将存入的内容
            # doc.css(".entry-content").each do |entry_content|
            #   content = entry_content.children.to_html unless entry_content.nil?
            #   news_teaching_content_tmp.merge!({content: content})
            # end
            # p "--------news_entry--------"
            # p news_teaching_content_tmp
            # @news_teaching_content = news_teaching_content_tmp
          end
        end

        unless doc.at_css(".content").nil? && doc.at_css(".markitup-box").nil?
          p "-----------进来了--------------"
          entry_title = doc.css(".mod-head").at_css("h1").children.to_html unless doc.css(".mod-head").at_css("h1").nil?
          unless @title_saved.include?(entry_title)
            @title_saved << entry_title
            content = doc.css(".content").children.to_html
            p "-------------内容-------------------"
            p content
            @news_teaching_content = {title: entry_title, content: content, source_site: @site}
          end
        end

        # 去除重复链接
        # @todo.uniq
        # 打印信息, 写入文件or数据库
        # puts "#{@visited}"
        # p @titles.uniq.compact
        write_results_to_database
        # write_results_to_file('title_out')
        crawl
      rescue OpenURI::HTTPError
        puts "404"
        crawl
      rescue RuntimeError
        puts "redirection forbidden"
        crawl
      rescue URI::InvalidURIError
        puts "bad URI"
        crawl
      ensure

      end
    end

    # 程序开始函数
    def crawl
      path = nil
      loop do
        # 选取找到的链接中的一个链接
        path = @todo.shift
        break if path.nil?
        # 如果是访问过的链接就重新选取
        break unless @visited.include?(path)
        # 去掉外部链接
        # 去掉特殊链接
      end
      if path.nil?
        puts "结束"
        # 输出抓取内容
        # post_title
        return
      end
      find_link(path)
    end

    # 需要爬取的网站首页
    def site(url)
      puts "--------Ready---------"
      if url.empty?
        puts "URL is blank"
      else
        @site = url
        @todo << @site
      end
    end

    # 写入mysql
    def write_results_to_database
      news_teaching = Post.new(@news_teaching_content)
      if news_teaching.save
        puts "--------save success!--------"
      else
        puts "--------save error!--------"
      end
    end

	end
end