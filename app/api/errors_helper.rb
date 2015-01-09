# -*- encoding : utf-8 -*-
module ErrorsHelper

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

  rescue_from :all do |exception|
    trace = exception.backtrace

    message = "\n#{exception.class} (#{exception.message}):\n"
    message << exception.annoted_source_code.to_s if exception.respond_to?(:annoted_source_code)
    message << "  " << trace.join("\n  ")
    API.logger.add Logger::FATAL, message
    rack_response(API.format_err_msg("500 Internal Server Error", 500), 500)
  end

end
