# rack层加密api
# module Rack
#   class ApiAuth

#     AUTHORIZATION_STRING = 'HTTP_AUTHORIZATION'.freeze
#     def initialize(app, config={})
#       @app = app
#       config.symbolize_keys!
#       @secret = config[:secret]
#     end

#     def call(env)
#       if env[AUTHORIZATION_STRING].present? 
#         auth_token = env[AUTHORIZATION_STRING]
#         begin
#           token_info_arr = JWT.decode auth_token, @secret
#         rescue
#           return [200, {'Content-Type' => 'application/json'}, [{error:{status: 400, message: 'Token Format Error'}}.to_json]]
#         end
#         token_hash = token_info_arr.select{|arr| arr.keys.include?('token')}[0]
#         token = token_hash['token']
#         expired_at = token_hash['expired_at'].to_i
#         return [200, {'Content-Type' => 'application/json'}, [{error:{status: 401, message: 'Token Expired'}}.to_json]]  unless Time.now.to_i < expired_at
#         env[AUTHORIZATION_STRING] = token
#         @app.call(env)
#       else
#         return [200, {'Content-Type' => 'application/json'}, [{error:{status: 401, message: 'Token Expired'}}.to_json]]
#       end
#     end

#   end
# end