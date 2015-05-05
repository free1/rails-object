# encoding=utf-8
module V1
  module WeiXin
    class Articles < Grape::API
      version 'v1', using: :path

      resource :articles do
      	
      	desc '评论列表'
      end

    end
  end
end