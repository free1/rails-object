class Upload::QiniuController < ApplicationController

	# /upload/qiniu/image_up_token
	def image_up_token
		rb = %Q({"image_path":$(key),"hash":$(hash),"width":$(imageInfo.width),"height":$(imageInfo.height), "file_path":"#{QiniuUploadUrl}/$(key)"})
		uptoken = Qiniu.generate_upload_token(:scope => QiniuScope, return_body: rb, deadline: (Time.now + 30.seconds).to_i, :expires_in => QiniuExpiresIn)

		render json: {uptoken: uptoken}
	end

end