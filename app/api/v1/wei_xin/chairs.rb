# encoding=utf-8
module V1
  module WeiXin
    class Chairs < Grape::API
      version 'v1', using: :path

      helpers do
        params :pagination do
          optional :page, type: Integer, default: 1, desc: '第几页'
          optional :per_page, type: Integer, default: 10, desc: '分几页'
        end
      end

      resource :chairs, desc: '日知讲座' do

        desc '讲座列表'
        params do
          use :pagination
        end
        get do
          chairs = Chair.order(id: :desc).paginate(page: params[:page], per_page: params[:per_page])
          present chairs, with: V1::Entities::Chair::Chairs
        end

        route_param :id do
          desc '讲座详情'
          get do
            chair = Chair.find(params[:id])
            present chair, with: V1::Entities::Chair::Chairs
          end

          desc '讲座关注'
          post '/collect' do
            authenticate!
            current_user.like!(params[:id], 'Chair')
            present :result, true
          end

          desc '讲座取消关注'
          delete '/cancel_collect' do
            authenticate!
            current_user.cancel_like!(params[:id], 'Chair')
            present :result, true
          end

        end
      end

    end
  end
end
