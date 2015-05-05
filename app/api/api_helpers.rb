# -*- encoding : utf-8 -*-
module APIHelpers

  def get_request_ip
    request.ip
  end

  def current_user
  	token = headers["Http-Access-Token"]
    return super unless token
    # remember_token = User.encrypt(token)
    @current_user ||= User.find_by(remember_token: remember_token)
  end

  # 是否登录
  def authenticate!
    error!('401 Unauthorized', 401) unless current_user
  end

end
