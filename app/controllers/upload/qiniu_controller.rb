class Upload::QiniuController < ApplicationController

  def image_up_token
    rb = %Q({"image_path":$(key),"hash":$(hash),"width":$(imageInfo.width),"height":$(imageInfo.height)})
    uptoken = Qiniu.generate_upload_token(:scope => 'free', return_body: rb, deadline: (Time.now + 30.seconds).to_i, :expires_in => 12*60*60)

    render json: {uptoken: uptoken}
  end

end