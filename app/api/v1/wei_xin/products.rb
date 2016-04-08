# encoding=utf-8
module V1
  module WeiXin
    class Products < Grape::API
      version 'v1', using: :path

      resource :products, desc: '商品相关' do
        
        desc '商品列表'
        params do
          optional :page, type: Integer, default: 1
          optional :per_page, type: Integer, default: 10
        end
        get do
          products = Product.order(id: :desc).paginate(page: params[:page], per_page: params[:per_page])
          present products, with: V1::Entities::Products
        end

        route_param :id do
          desc '商品详情'
          get do
            product = Product.find(params[:id])
            present product, with: V1::Entities::Product
          end
        end
      end

    end
  end
end
