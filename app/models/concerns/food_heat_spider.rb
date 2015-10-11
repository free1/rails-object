# encoding=utf-8
# 内容抓取
require 'open-uri'
require 'nokogiri'

# 程序入口
# require 'free_spider'
# FoodHeatSpider::Begin.start

module FoodHeatSpider
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
          # 访问过的链接放入数组
          @visited << path
          # p "================"
          # p @visited
          # p path
          doc = Nokogiri::HTML(html)
          # 抓取链接加入爬取队列
          doc.css("a").map do |href|
            # 处理链接
            href = href.attributes["href"].value unless href.attributes["href"].nil?
            # 去除重复链接
            href = @site + href unless href.include?("#{@site}")

            # 加入爬取队列, 选取需要的链接
            @todo << href if href.include?("tools") && href.include?("mod=foods")
          end

          # 抓取主要内容(健康网站食物热量表)
          unless doc.at_css(".food-intr-wrap").nil?
            p "-----------进来了--------------"
            entry_img = doc.css(".illu").children.css("a").children.last.attributes["src"].value
            nutrition_info = doc.css(".nutr-tag").css("ul").css("li").css("span").map do |nutrition_info_tag|
              nutrition_info_tag.children.to_html
            end
            nutrition_info = Hash[*nutrition_info]
            nutrition_value, edible_effect, applicable_people = ""
            doc.css(".intr-module").each do |nutrition_effect|
              if nutrition_effect.css("h2").children.text == "营养价值"
                nutrition_value = nutrition_effect.css("p").text
              end
              if nutrition_effect.css("h2").children.text == "食用效果"
                edible_effect = nutrition_effect.css("p").text
              end
              if nutrition_effect.css("h2").children.text == "适用人群"
                applicable_people = nutrition_effect.css("p").text
              end
            end
            p "-------抓取结果------"
            p entry_img, nutrition_info, nutrition_value, edible_effect, applicable_people
            p "==============="
            # entry_title = doc.css(".mod-head").at_css("h1").children.to_html unless doc.css(".mod-head").at_css("h1").nil?
            # unless @title_saved.include?(entry_title)
            #   @title_saved << entry_title
            #   content = doc.css(".content").children.to_html
            #   p "-------------内容-------------------"
            #   p content
            #   @news_teaching_content = {title: entry_title, content: content, source_site: @site}
            # end
          end

          # 去除重复链接
          # p @todo.uniq
          # 打印信息, 写入文件or数据库
          # puts "#{@visited}"
          # p @titles.uniq.compact
          # write_results_to_database
          # write_results_to_file('title_out')
        rescue OpenURI::HTTPError
          puts "404"
        rescue RuntimeError
          puts "redirection forbidden"
        rescue URI::InvalidURIError
          puts "bad URI"
        ensure
          crawl
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
          @site = "http://www.shoushen.com/"
          # @site = url
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

      def self.start
        spider = FoodHeatSpider::Begin.new
        spider.plan do
          site 'http://www.shoushen.com/tools.php?mod=foods'
        end
        spider.crawl
      end

    end
end