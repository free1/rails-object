# encoding=utf-8
class ArticlesController < ApplicationController
	before_action :signed_in_user

	def index
		@articles = Article.paginate(page: params[:page], per_page: 10)
	end

  def new
    @article = current_user.articles.build
  end

  def create
  	article = current_user.articles.build(article_params)
  	if article.save
  		flash[:success] = '栏目创建成功!'
  		redirect_to articles_path
  	else
  		render 'new'
  	end
  end

  def edit
  	@article = current_user.articles.find(params[:id])
  end

  def update
  	article = current_user.articles.find(params[:id])
  	if article.update(article_params)
  		flash[:success] = '栏目编辑成功!'
  		redirect_to articles_path
  	else
  		flash[:success] = '栏目编辑失败!'
  		redirect_to :back
  	end
  end

  private

  	def article_params
  		params.require(:article).permit(:title, :content, :cover_path, :status)
  	end

end