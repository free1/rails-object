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

          desc '收藏'
          post '/collect' do
            authenticate!
            obj_present!('Chair', params[:id])
            current_user.like!(params[:id], 'Chair', UserCollect.kinds["favorite"])
            present :result, true
          end

          desc '取消收藏'
          delete '/cancel_collect' do
            authenticate!
            obj_present!('Chair', params[:id])
            current_user.cancel_like!(params[:id], 'Chair', UserCollect.kinds["favorite"])
            present :result, true
          end

          desc '创建评论'
          params do
            requires :content, type: String
          end
          post '/comments' do
            authenticate!
            chair = Chair.find(params[:id])
            comment = chair.comments.build(content: params[:content], user_id: current_user.id)
            if comment.save
              present comment, with: V1::Entities::Comment::Comments
            else
              present :result, false
            end
          end

          desc '评论列表'
          params do
            use :pagination
          end
          get '/comments' do
            chair = Chair.find(params[:id])
            comments = chair.comments.paginate(page: params[:page], per_page: params[:per_page])
            present comments, with: V1::Entities::Comment::Comments
          end

          desc '赞'
          post '/zan' do
            authenticate!
            obj_present!('Chair', params[:id])
            current_user.like!(params[:id], 'Chair', UserCollect.kinds["zan"])
            present :result, true
          end

          desc '取消赞'
          delete '/cancel_zan' do
            authenticate!
            obj_present!('Chair', params[:id])
            current_user.cancel_like!(params[:id], 'Chair', UserCollect.kinds["zan"])
            present :result, true
          end

        end
      end

    end
  end
end
