# encoding=utf-8
module V1
  module WeiXin
    class ArticleLists < Grape::API
      version 'v1', using: :path

 			helpers do
        params :pagination do
          optional :page, type: Integer, default: 1, desc: '第几页'
          optional :per_page, type: Integer, default: 10, desc: '分几页'
        end
      end

      resource :article_lists, desc: '日知栏目下文章' do

        desc '栏目下文章列表'
        params do
        	requires :article_id, type: Integer, desc: '栏目id'
          use :pagination
        end
        get do
          article_lists = Article.find(params[:article_id]).article_lists.order(id: :desc)
          present article_lists, with: V1::Entities::Article::ArticleLists
        end

        route_param :id do
          desc '栏目下文章详情'
          get do
          	article_list = ArticleList.find(params[:id])
          	present article_list, with: V1::Entities::Article::ArticleListDetails
          end
        end

      end
    end
  end
end