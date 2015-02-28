module QiniuCheck
	extend ActiveSupport::Concern

	module ClassMethods

		# 生成二维码
		def generate_qr_code_img(info, width, height)
			qr = RQRCode::QRCode.new( info, :size => 4, :level => :h )
			path = qr.to_img.resize(width, height).save("tmp/#{info}.png")
		end

		# 后端上传图片
		def upload_image_with_path(path)
			rb = %Q({"image_path":$(key)})
			# 生成 uptoken
			put_policy = Qiniu::Auth::PutPolicy.new(
			    QiniuScope     # 存储空间
			    # key,        # 最终资源名，可省略，即缺省为“创建”语义
			    # expires_in, # 相对有效期，可省略，缺省为3600秒后 uptoken 过期
			    # deadline    # 绝对有效期，可省略，指明 uptoken 过期期限（绝对值），通常用于调试
			)
			put_policy.return_body = rb
			uptoken = Qiniu::Auth.generate_uptoken(put_policy)
			# 上传文件到七牛
			code, result, response_headers = Qiniu::Storage.upload_with_put_policy(
			    put_policy,     # 上传策略
			    path     # 本地文件名
			    # key,            # 最终资源名，可省略，缺省为上传策略 scope 字段中指定的Key值
			    # x_var           # 用户自定义变量，可省略，需要指定为一个 Hash 对象
			)
			QiniuUploadUrl + result['image_path']
		end
	
	end

end