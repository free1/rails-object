# == Schema Information
#
# Table name: posts
#
#  id          :integer          not null, primary key
#  title       :string(255)
#  content     :text(65535)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :integer
#  author      :string(255)
#  status      :integer          default(0)
#  watch_count :integer          default(0)
#  cover_path  :string(255)
#  source_site :string(255)
#
require 'free_spider'
class Post < ActiveRecord::Base
	include Redis::Objects
	include Commentable
	include Searchable
	counter :show_count
	set :score_post, global: true

	belongs_to :user
	validates :title, presence: true, uniqueness: true, on: :create
	validates :content, presence: true

	# 搜索sunspot
	# searchable do
	# 	text :title, :content

	# 	integer :id
	# end
	# 搜索es
	# def as_indexed_json(options={})
	# end

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
				# post.watch_count = post.show_count
				if post.update(watch_count: post.watch_count + post.show_count.to_i)
					score_post.delete(post_id)
					post.show_count.reset
					# post.show_count.decr
				else
					p post.errors
				end
			end
		end

	end
	
end
