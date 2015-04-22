class PostsController < ApplicationController

	def index
		@posts = Post.order(id: :desc).paginate(page: params[:page], per_page: 12)
	end

	def show
		@post = Post.find(params[:id])	
	end

end