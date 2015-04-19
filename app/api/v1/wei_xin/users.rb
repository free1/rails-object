# encoding=utf-8
module V1
  module WeiXin
    class Users < Grape::API
      version 'v1', using: :path

      resource :users do
        
        desc '用户列表'
        params do
          optional :page, type: Integer, default: 1
          optional :per_page, type: Integer, default: 10
        end
        get do
          users = User.order(id: :desc).paginate(page: params[:page], per_page: params[:per_page])

          present users, with: V1::Entities::Users
        end
      end

    end
  end
end
