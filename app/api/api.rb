require 'grape-swagger'

class API < Grape::API
    prefix 'api'
    format :json

    helpers APIHelpers
    # helpers ErrorsHelper
    before do
        header['Access-Control-Allow-Origin'] = '*'
        header['Access-Control-Request-Method'] = '*'
    end

    mount ::V1::Base

    # 生成文档 /home/api_swagger_ui
    # http://localhost:3000/api/swagger_doc
    # http://petstore.swagger.io/
    # base_path = Rails.env.production? ? "#{ENV['URL_SCHEMA']}://#{ENV['URL_HOST']}" : nil
    # add_swagger_documentation base_path: base_path,
    #   mount_path: '/doc/swagger', api_version: 'v1',
    #   hide_documentation_path: true, hide_format: true
    add_swagger_documentation api_version: 'v1', hide_format: true, hide_documentation_path: true
end
