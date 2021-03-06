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

          desc '栏目下最新文章'
          get '/newest' do
            newest_article_list = Article.find(params[:id]).article_lists.last
            present newest_article_list, with: V1::Entities::Article::ArticleListDetails
          end

          desc '日知栏目关注'
          post '/collect' do
            authenticate!
            obj_present!('Article', params[:id])
            current_user.like!(params[:id], 'Article', UserCollect.kinds["favorite"])
            present :result, true
          end

          desc '日知栏目取消关注'
          delete '/cancel_collect' do
            authenticate!
            obj_present!('Article', params[:id])
            current_user.cancel_like!(params[:id], 'Article', UserCollect.kinds["favorite"])
            present :result, true
          end
          
        end
      end

    end
  end
end
