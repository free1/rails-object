require 'grape-swagger'

class API < Grape::API
    format :json
    default_format :json

    content_type :json, "application/json;charset=UTF-8"

    helpers APIHelpers
    # helpers ErrorsHelper

    class << self
      def logger
        if Rails.env == 'development'
          Rails.logger
        else
          Logger.new("#{Rails.root}/log/api.log")
          # Logger.new("#{Rails.root}/log/development.log")
        end
      end
    end

    mount ::V1::Base

    # 生成文档 /home/api_swagger_ui
    # http://localhost:3000/api/swagger_doc
    # http://petstore.swagger.io/
    # base_path = Rails.env.production? ? "#{ENV['URL_SCHEMA']}://#{ENV['URL_HOST']}" : nil
    # add_swagger_documentation base_path: base_path,
    #   mount_path: '/doc/swagger', api_version: 'v1',
    #   hide_documentation_path: true, hide_format: true
    add_swagger_documentation base_path: nil, class_name: 'base', api_version: 'v1', hide_format: true, hide_documentation_path: true
end
