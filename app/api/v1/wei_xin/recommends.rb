# encoding=utf-8
module V1
  module WeiXin
    class Recommends < Grape::API
      version 'v1', using: :path

      desc '推荐滚动内容'
      params do
      	optional :num, type: Integer, desc: '需要几个图片'
      end
      get '/roll_nav_infos' do
      	roll_nav_infos = RollNavInfo.order(id: :desc).first(params[:num])
      	present roll_nav_infos, with: V1::Entities::Recommend
      end
    end
  end
end