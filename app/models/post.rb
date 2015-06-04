require 'free_spider'

class Post < ActiveRecord::Base
	include Redis::Objects
	counter :show_count
	set :score_post, global: true

	belongs_to :user
	validates :title, presence: true, uniqueness: true
	validates :content, presence: true

	# 搜索
	searchable do
		text :title, :content

		integer :id
	end

	class << self

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
