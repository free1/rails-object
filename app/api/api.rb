class API < Grape::API
  prefix 'api'
  format :json

  helpers APIHelpers
  # helpers ErrorsHelper

  mount V1::Base

  # 生成文档
  base_path = Rails.env.production? ? "#{ENV['URL_SCHEMA']}://#{ENV['URL_HOST']}" : nil
  # add_swagger_documentation base_path: base_path,
  #   mount_path: '/doc/swagger', api_version: 'v1',
  #   hide_documentation_path: true
  add_swagger_documentation api_version: 'v1'

end
