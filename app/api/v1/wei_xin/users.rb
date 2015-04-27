# encoding=utf-8
require 'net/http'

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

      desc '用户名登录'
      params do
        requires :name, type: String
        requires :password, type: String
      end
      post '/login' do
        user = User.find_by(name: params[:name])
        if user && user.authenticate(params[:password])
          present user, with: V1::Entities::Users
        else
          p "----无效的用户名/密码!----"
        end
      end

      desc '新浪weibo登录请求user信息'
      params do
        requires :access_token, type: String
        requires :uid, type: String
      end
      get '/weibo_login' do
        user = User.get_weibo_user(params[:uid])
        unless user
          user_info = User.get_weibo_user_info(params[:access_token], params[:uid])
          weibo_info = {uid: params[:uid], privider: 'weibo'}
          user_info.merge! weibo_info
          user = User.create_from_weibo(user_info)
        end
        present user, with: V1::Entities::Users
      end

    end
  end
end
