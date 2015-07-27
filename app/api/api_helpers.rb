# -*- encoding : utf-8 -*-
module APIHelpers

  def get_request_ip
    request.ip
  end

  def current_user
    if request.headers["Http-Access-Token"]
      token = request.headers["Http-Access-Token"]
    elsif (cookies[:remember_token])
      token = User.encrypt(cookies[:remember_token])
    end
    # remember_token = User.encrypt(token)
    @current_user ||= User.find_by(remember_token: token)
  end

  # 是否登录
  def authenticate!
    error!('401 Unauthorized', 401) unless current_user
  end

  # 记录是否存在
  def obj_present!(class_name, id)
    class_name.constantize.find(id)
  end

end
