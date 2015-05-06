# encoding=utf-8
module V1
  module WeiXin
    class Articles < Grape::API
      version 'v1', using: :path

      helpers do
        params :pagination do
          optional :page, type: Integer, default: 1, desc: '第几页'
          optional :per_page, type: Integer, default: 10, desc: '分几页'
        end
      end

      resource :articles, desc: '日知栏目' do
        
        desc '日知栏目列表'
        params do
          use :pagination
        end
        get do
          articles = Article.order(id: :desc).paginate(page: params[:page], per_page: params[:per_page])

          present articles, with: V1::Entities::Article::Articles
        end

        route_param :id do
          desc '日知栏目详情'
          get do
            article = Article.find(params[:id])
            present article, with: V1::Entities::Article::ArticleDetails, user: current_user
          end

          desc '日知栏目关注'
          post '/collect' do
            current_user.like!(params[:id], 'Article')
            present :result, true
          end

          desc '日知栏目取消关注'
          delete '/cancel_collect' do
            current_user.cancel_like!(params[:id], 'Article')
            present :result, true
          end

          # desc '创建评论'
          # params do
          #   requires :content, type: String
          # end
          # post '/comments' do
          #   article = Article.find(params[:id])
            
          # end

          desc '评论列表'
          params do
            optional :page, type: Integer, default: 1
            optional :per_page, type: Integer, default: 10
          end
          get '/comments' do
            article = Article.find(params[:id])
            comments = article.comments.paginate(page: params[:page], per_page: params[:per_page])
            present comments, with: V1::Entities::Comment::Comments
          end

        end
      end

    end
  end
end
