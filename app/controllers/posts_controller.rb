class PostsController < ApplicationController

	def index
		@posts = Post.order(id: :desc).paginate(page: params[:page], per_page: 20)
		# @posts = Post.paginate(page: params[:page], per_page: 12)
	end

	def show
		@post = Post.find(params[:id])	
		Post.add_watch_count(params[:id])
		@comments = @post.comments.includes(:user)
		@comment = Comment.new
	end

	def search
		# sphinx
		# @posts = Post.search Riddle::Query.escape(params[:query])
		# sunspot
		# @posts = Post.search do
		# 	fulltext(params[:query])
		# 	order_by(:id, :desc)
		# end.results
		# elasticsearch
		@posts = Post.simple_search(params[:query]).records.paginate(page: params[:page], per_page: 12)
		render 'index'
	end

end