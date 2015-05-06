# encoding=utf-8
module V1
  module WeiXin
    class Posts < Grape::API
      version 'v1', using: :path

      resource :posts do
        
        desc '文章列表'
        params do
          optional :page, type: Integer, default: 1
          optional :per_page, type: Integer, default: 10
        end
        get do
          posts = Post.order(id: :desc).paginate(page: params[:page], per_page: params[:per_page])

          present posts, with: V1::Entities::Posts
        end
      end

    end
  end
end
