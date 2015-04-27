# encoding=utf-8
# api 第三方信息处理
module ThirdParty
	extend ActiveSupport::Concern

	module ClassMethods
		WEIBO_URL = "https://api.weibo.com/2/users/show.json"

		# 判断微博用户是否存在
		def get_weibo_user(uid)
			Authentication.locate('uid' => uid, 'provider' => 'weibo').try(:user)
		end
		# 获取微博用户信息
		def get_weibo_user_info(access_token, uid)
			uri = URI.parse(WEIBO_URL)
      params = { :access_token => access_token, :uid => uid }
      uri.query = URI.encode_www_form(params)
      res = Net::HTTP.get_response(uri).body
      result = JSON.parse res.force_encoding("UTF-8")
      result
		end
		# 创建微博用户
		def create_from_weibo(user_info)
			password = User.new_remember_token
			remember_token = User.new_remember_token

      begin
        User.transaction do
          user = create(name: user_info['name'], avatar_path: user_info['profile_image_url'], 
          							password: password, remember_token: remember_token)
          user.authentications.create(uid: user_info[:uid], provider: 'weibo', user_id: user.id)
          user
        end
      rescue Exception => ex
        puts "-------创建失败--------"
        puts "-------#{ex.message}--------"
      end
		end

	end

end