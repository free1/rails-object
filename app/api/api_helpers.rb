# -*- encoding : utf-8 -*-
module APIHelpers

  def get_request_ip
    request.ip
  end

  def current_user
    remember_token = User.encrypt(cookies[:remember_token])
    @current_user ||= User.find_by(remember_token: remember_token)
  end

end
