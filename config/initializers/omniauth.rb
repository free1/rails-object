Rails.application.config.middleware.use OmniAuth::Builder do
  provider :weibo, ENV['WEIBO_KEY'], ENV['WEIBO_SECRET']
  provider :qq_connect, ENV['QQ_CONNECT_APP_KEY'], ENV['QQ_CONNECT_APP_SECRET'], scope: "get_user_info,add_share"
  provider :github, ENV['GITHUB_KEY'], ENV['GITHUB_SECRET']
  provider :douban, ENV['DOUBAN_KEY'], ENV['DOUBAN_SECRET']
  provider :open_wechat, ENV['OPEN_WECHAT_KEY'], ENV['OPEN_WECHAT_SECRET'], :scope => 'snsapi_login'
  provider :wechat, ENV["MOBILE_WECHAT_KEY"], ENV["MOBILE_WECHAT_SECRET"], :authorize_params => {:scope => "snsapi_base"}
end