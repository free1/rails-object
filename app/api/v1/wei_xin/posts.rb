# encoding=utf-8
module V1
  module WeiXin
    class Posts < Grape::API
      version 'v1', using: :path

      resource :posts, desc: '爬取文章' do
        
        desc '文章列表'
        params do
          optional :page, type: Integer, default: 1
          optional :per_page, type: Integer, default: 10
        end
        get do
          posts = Post.order(id: :desc).paginate(page: params[:page], per_page: params[:per_page])
          present posts, with: V1::Entities::Posts
        end

        route_param :id do
          desc '文章详情'
          get do
            post = Post.find(params[:id])
            present post, with: V1::Entities::Post
          end
        end
      end

    end
  end
end
