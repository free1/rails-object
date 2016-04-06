module Tool
  module Wechat

    class JssdkSign
      APPID = 'appid'.freeze
      APPSECRET = 'appsecret'.freeze
      TOKEN_URL = 'https://api.weixin.qq.com/cgi-bin/token'.freeze
      TICKET_URL = 'https://api.weixin.qq.com/cgi-bin/ticket/getticket'.freeze

      class << self
        def get_data(uri, params)
          uri = URI(uri)
          uri.query = URI.encode_www_form(params)
          res = Net::HTTP.get_response(uri)
          if res.is_a?(Net::HTTPSuccess)
            result = JSON.parse(res.body)
          end
        end

        def get_access_token
          access_token = $redis.get("access_token")
          unless access_token
            uri = TOKEN_URL
            params = {
              grant_type: 'client_credential',
              appid: APPID,
              secret: APPSECRET
            }
            access_token = get_data(uri, params)['access_token']
            $redis.set("access_token", access_token)
            $redis.expire("access_token", 60.minutes)
          end
          access_token
        end

        def get_ticket
          ticket = $redis.get("ticket")
          unless ticket
            uri = TICKET_URL
            params = {
              type: 'jsapi',
              access_token: get_access_token
            }
            result = get_data(uri, params)
            if result['errcode'] = 0
              ticket = result['ticket']
              $redis.set("ticket", ticket)
              $redis.expire("ticket", 60.minutes)
            end
          end
          ticket
        end

        def generate_signature(share_url)
          timestamp = Time.now.to_i
          noncestr = SecureRandom.hex(8)
          params = "jsapi_ticket=#{get_ticket}&noncestr=#{noncestr}&timestamp=#{timestamp}&url=#{share_url}"
          signature = Digest::SHA1.hexdigest(params)
          result = {signature: signature, timestamp: timestamp, noncestr: noncestr}
        end

        # Tool::Wechat::JssdkSign.wx_config(params[:current_url])
        def wx_config(share_url)
          signature_params = generate_signature(share_url)
          signature = signature_params[:signature]
          timestamp = signature_params[:timestamp]
          noncestr = signature_params[:noncestr]
          result = {appid: APPID, timestamp: timestamp, noncestr: noncestr, signature: signature}
        end

      end
    end
  end
end