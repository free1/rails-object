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

end