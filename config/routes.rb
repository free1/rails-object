class ActionDispatch::Routing::Mapper
  def draw(routes_name)
    instance_eval(File.read(Rails.root.join("config/routes/#{routes_name}.rb")))
  end
end

require 'sidekiq/web'
Rails.application.routes.draw do

  mount Sidekiq::Web => '/sidekiq'

  mount API => "/"

  root 'home#index'
  get 'home/api_swagger_ui'
  get '/openinapp_instruction' => 'home#openinapp_instruction', as: :openinapp_instruction

  %w(404 422 500).each do |code|
    get code, to: "errors#show", code: code
  end


  # 用户相关
  get 'login' => 'sessions#new'
  delete 'logout' => 'sessions#destroy'
  resources :sessions, only: [:new, :create]
  # 第三方登录
  match "/auth/:provider/callback", :to => 'omniauths#create', via: [:get, :post]
  # 工具相关
  match "/send_verify_code", to: 'tools#send_verify_code', via: :post
  # 微信测试删除好友页面
  match "/wechat_deleted_friends", to: 'tools#wechat_deleted_friends', via: :get
  # 验证微信公众账号
  match "/valid_public_wechat", to: 'tools#valid_public_wechat', via: :get

  resources :users do
    collection do
      get 'verify_email'
    end
    member do
      get :following, :followers, :feeds, :products
    end
  end
  resource :settings do
    collection do
      get :account
    end
  end
  resources :relationships, only: [:create, :destroy]
  # todo 可以把user的功能都放到module下
  scope module: :member do
    resources :collects, only: [:create, :destroy]
    resources :tags, only: [:index]
    # 消息通知
    resources :notifications, only: [:index, :destroy] do
      # collection do
        # get :unread_count
      # end
    end
    # 重置密码
    resources :password_resets
  end

  # 商品相关
  resources :products do
    resources :comments, only: [:create, :destroy]
  end

  # 抓取内容news
  resources :posts do
    resources :comments, only: [:create, :destroy]
    collection do
      get :search
    end
  end

  # 日知文章
  resources :articles do
    resources :article_lists
  end

  # 日知讲座
  resources :chairs


  # 七牛上传文件
  namespace :upload do
    resources :qiniu, only: [] do
      collection do
        get 'image_up_token'
      end
    end
  end

  # 购买功能
  resources :orders


  # 管理员
  draw :admin
  # 新版api
  draw :api

end
