class ToolsController < ApplicationController

  def send_verify_code
    phone, verify_code = Phone.update_verify_code(params[:phone_no])
    # Tool::SendSms.send_sms(params[:phone_no], template)
    if phone.errors.count == 0
      phone.update(verify_code: verify_code)
      render nothing: true
    else
      error(401, "phone invalid")
    end
  end

  def wechat_deleted_friends
    url = "https://login.weixin.qq.com/jslogin"
    params = {
      appid: 'wx782c26e4c19acffb',
      fun: 'new',
      lang: 'zh_CN'
    }
    uri = URI.parse(url)
    uri.query = URI.encode_www_form(params)
    res = Net::HTTP.get_response(uri)
    body = res.body
    data = JSON.parse(body)
  end

  def valid_public_wechat
    render text: params[:echostr]
  end

end