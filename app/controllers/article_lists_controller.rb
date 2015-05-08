# encoding=utf-8
class ArticleListsController < ApplicationController
	before_action :signed_in_user
	before_action :find_article

	def index
		@article_lists = @article.article_lists.paginate(page: params[:page], per_page: 10)
	end

	def new
		@article_list = @article.article_lists.build
	end

	def create
		article_list = @article.article_lists.build(article_list_params)
		if article_list.save
			flash[:success] = "期刊创建成功!"
			redirect_to article_article_lists_path(@article)
		else
			render 'new'
		end
	end

	def edit
		@article_list = @article.article_lists.find(params[:id])
	end

	def update
		@article_list = @article.article_lists.find(params[:id])
		if @article_list.update(article_list_params)
			flash[:success] = '期刊编辑成功!'
			redirect_to article_article_lists_path(@article)
		else
			flash[:success] = '期刊编辑失败!'
			redirect_to :back
		end
	end

	def destroy
		
	end

	def destroy
		article_list = @article.article_lists.find(params[:id])
		article_list.destroy
		redirect_to :back
	end

	private 

		def find_article
			@article = Article.find(params[:article_id])
		end

		def article_list_params
			params.require(:article_list).permit(:content, :translate, :remark_on, :periods)
		end
end