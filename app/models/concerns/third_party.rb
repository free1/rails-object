# encoding=utf-8
# api 第三方信息处理
module ThirdParty
	extend ActiveSupport::Concern

	module ClassMethods
		WEIBO_URL = "https://api.weibo.com/2/users/show.json"
		QQ_URL = "https://graph.qq.com/user/get_user_info"

		# 判断用户是否存在
		def get_user(uid, provider)
			Authentication.locate('uid' => uid, 'provider' => provider).try(:user)
		end

		# 获取用户信息
		def get_user_info(access_token, uid, provider)
			case provider
			when 'weibo'
				uri = URI.parse(WEIBO_URL)
      	params = { :access_token => access_token, :uid => uid }
			when 'qq'
				uri = URI.parse(QQ_URL)
	      # params = { :access_token => access_token, :uid => uid, :oauth_consumer_key => ENV['QQ_CONNECT_APP_KEY'] }
	      params = { :access_token => access_token, :openid => uid, :oauth_consumer_key => 1104504051 }
			end
      uri.query = URI.encode_www_form(params)
      res = Net::HTTP.get_response(uri).body
      result = JSON.parse res.force_encoding("UTF-8")
      result
		end

		# 创建用户
		def create_from_user(user_info, provider)
			password = User.new_remember_token
			remember_token = User.new_remember_token

      begin
      	case provider
      	when 'weibo'
      		User.transaction do
	          user = create(name: user_info['name'], avatar_path: user_info['profile_image_url'], 
	          							password: password, remember_token: User.encrypt(remember_token))
	          user.authentications.create(uid: user_info[:uid], provider: provider, user_id: user.id)
	          user
	        end
      	when 'qq'
      		User.transaction do
	          user = create(name: user_info['nickname'], avatar_path: user_info['figureurl_2'], 
	          							password: password, remember_token: User.encrypt(remember_token))
	          user.authentications.create(uid: user_info[:uid], provider: provider, user_id: user.id)
	          user
	        end
      	end
      rescue Exception => ex
        puts "-------创建失败--------"
        puts "-------#{ex.message}--------"
      end
		end

	end

end