# encoding=utf-8
module V1
  module WeiXin
    class Articles < Grape::API
      version 'v1', using: :path

      resource :articles do
        
        desc '日知文章列表'
        params do
          optional :page, type: Integer, default: 1
          optional :per_page, type: Integer, default: 10
        end
        get do
          articles = Article.order(id: :desc).paginate(page: params[:page], per_page: params[:per_page])

          present articles, with: V1::Entities::Article::Articles
        end

        route_param :id do
          desc '日知文章详情'
          params do
          end
          get do
            article = Article.find(params[:id])
            present article, with: V1::Entities::Article::ArticleDetails
          end
        end
      end

    end
  end
end
