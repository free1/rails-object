# encoding=utf-8
require 'net/http'

module V1
  module WeiXin
    class Users < Grape::API
      version 'v1', using: :path

      resource :users, desc: '用户系统' do
        
        desc '用户列表'
        params do
          optional :page, type: Integer, default: 1
          optional :per_page, type: Integer, default: 10
        end
        get do
          users = User.order(id: :desc).paginate(page: params[:page], per_page: params[:per_page])
          present users, with: V1::Entities::User::Users
        end

        desc '根据地理位置显示用户'
        params do
          requires :longitude, type: Float, default: 0.0, desc: '经度'
          requires :latitude, type: Float, default: 0.0, desc: '纬度'
        end
        get '/location' do
          # Searches users within 100 kilometers of (latitude, longitude)
          users = User.search do
            with(:location).in_radius(params[:latitude], params[:longitude], 100)
          end.results
          present users, with: V1::Entities::User::Users
        end

        desc '注册'
        params do
          requires :name, type: String
          requires :password, type: String
        end
        post '/signup' do
          remember_token = User.new_remember_token
          user = User.new(name: params[:name], password: params[:password], remember_token: User.encrypt(remember_token))
          if user.save
            present user, with: V1::Entities::User::Users
          else
            error!('validates errors', 409)
          end
        end

        desc '验证用户名'
        params do
          requires :name, type: String
        end
        post '/verify_username' do
          user = User.where(name: params[:name])
          if user.present?
            error!('validates errors', 409)
          else
            present :result, true
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
            present user, with: V1::Entities::User::Users
          else
            # present :result, false
            error!('401 Unauthorized', 401)
            # p "----无效的用户名/密码!----"
          end
        end

        desc '第三方登录'
        params do
          requires :access_token, type: String
          requires :uid, type: String
          requires :provider, type: String, default: 'weibo'
        end
        get '/third_party_login' do
          user = User.get_user(params[:uid], params[:provider])
          unless user
            user_info = User.get_user_info(params[:access_token], params[:uid], params[:provider])
            weibo_info = {uid: params[:uid], provider: params[:provider]}
            user_info.merge! weibo_info
            user = User.create_from_user(user_info, params[:provider])
          end
          present user, with: V1::Entities::User::Users
        end
      end

    end
  end
end
