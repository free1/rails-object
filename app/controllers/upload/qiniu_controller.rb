class Upload::QiniuController < ApplicationController

    # /upload/qiniu/image_up_token
    def image_up_token
        return_body = %Q({"image_path":$(key),"hash":$(hash),"width":$(imageInfo.width),"height":$(imageInfo.height), "file_path":"#{QiniuUploadUrl}/$(key)"})
        uptoken = Qiniu.generate_upload_token(:scope => QiniuScope, return_body: return_body, deadline: (Time.now + 30.seconds).to_i, :expires_in => QiniuExpiresIn)

        render json: {uptoken: uptoken}
    end

    # /upload/qiniu/video_up_token
    def video_up_token
        # 前端能拿到的参数
        return_body = %Q({"video_path":$(key),"hash":$(hash),"persistent_id":$(persistentId)})
        # 转码格式及分辨率设置
        persistent_options = %w(
                    vframe/jpg/offset/10
                    avthumb/mp4/vb/1000k/vcodec/libx264/acodec/libfaac/s/640x480/autoscale/1
                    avthumb/mp4/vb/1400k/vcodec/libx264/acodec/libfaac/s/1024x768/autoscale/1
                    avthumb/flv/ar/44100/vb/512k/vcodec/flv/acodec/libmp3lame/s/320x240/autoscale/1
                    avthumb/m3u8/segtime/10/vb/1000k/vcodec/libx264/acodec/libfaac/s/640x480/autoscale/1
                    avthumb/m3u8/segtime/10/vb/1500k/vcodec/libx264/acodec/libfaac/s/1024x768/autoscale/1)
        # 转码完成后的回调地址  TODO 写入配置文件
        persistent_notify_url = "#{APP_HOST}qiniu/qiniu_persistent_result"
        uptoken = Qiniu.generate_upload_token(
            scope: QiniuScope,
            deadline: (Time.now + 30.seconds).to_i,
            :expires_in => 12*60*60,
            return_body: return_body,
            persistent_ops: persistent_options.join(';'),
            persistent_notify_url: persistent_notify_url,
            persistent_pipeline: %w(product post other).sample
        )

        render json: {uptoken: uptoken}
    end

end