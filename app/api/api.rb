# encoding:utf-8
require 'grape-swagger'

module Grape
  class Entity
    format_with(:iso_timestamp) { |dt| dt.utc.iso8601 if dt }
    format_with(:iso_date) { |d| d.utc.to_date if d }
  end
end

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

      # 手动捕获的异常, 在这里返回
      def format_err_msg(message, status)
        {
            meta: {
                err_msg: message,
                result: false,
                status_code: status
            }
        }.to_json
      end
    end


    rescue_from ActiveRecord::RecordNotFound do
      rack_response(API.format_err_msg('数据不存在.', 404), 404)
    end

    rescue_from ActiveRecord::RecordInvalid do |error|
      rack_response(API.format_err_msg("数据验证错误: #{error}", 409), 409)
    end

    rescue_from Grape::Exceptions::ValidationErrors do |e|
      rack_response(API.format_err_msg("参数错误: #{e.message}", e.status), e.status)
    end

    rescue_from JSON::ParserError do |e|
      rack_response(API.format_err_msg("JSON解析出错: #{e.message}", e.status), e.status)
    end

    # rescue_from Grape::Exceptions::AboriginalError do |e|
    #   Rack::Response.new({
    #     error_code: e.status,
    #   }.merge(e.message).to_json, e.status).finish
    # end

    rescue_from :all do |exception|
      trace = exception.backtrace

      message = "\n#{exception.class} (#{exception.message}):\n"
      message << exception.annoted_source_code.to_s if exception.respond_to?(:annoted_source_code)
      message << "  " << trace.join("\n  ")
      API.logger.add Logger::FATAL, message
      rack_response(API.format_err_msg("未知错误", 500), 500)
    end


    mount ::V1::Base

    # 生成文档 /home/api_swagger_ui
    # http://petstore.swagger.io/
    # base_path = Rails.env.production? ? "#{ENV['URL_SCHEMA']}://#{ENV['URL_HOST']}" : nil
    # add_swagger_documentation base_path: base_path,
    #   mount_path: '/doc/swagger', api_version: 'v1',
    #   hide_documentation_path: true, hide_format: true
    add_swagger_documentation mount_path: '/doc', api_version: 'v1', hide_format: true, hide_documentation_path: true
end
