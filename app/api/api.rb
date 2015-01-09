class API < Grape::API
  helpers APIHelpers
  helpers ErrorsHelper

  prefix 'api'

  format :json

  # API Version: 1.0
  mount V1::WeiXin::Test

end
