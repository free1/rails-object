class NewApi::V2::BaseController < ActionController::Metal

  # 加载顺序不能变
  include AbstractController::Helpers
  include AbstractController::Rendering
  include ActionController::Redirecting
  include ActionView::Layouts
  include ActionController::Rendering
  include ActionController::Renderers::All
  include ActionController::MimeResponds
  include ActionController::ImplicitRender
  include ActionController::StrongParameters
  include ActionController::RequestForgeryProtection
  include ActionController::ForceSSL
  include AbstractController::Callbacks

  include ActionController::Helpers
  include ActionController::UrlFor
  include ActionController::ConditionalGet
  include ActionController::Caching
  include ActionController::Instrumentation
  include ActionController::ParamsWrapper
  include ActionController::DataStreaming
  include ActionController::Rescue

  include Rails.application.routes.url_helpers

  append_view_path "#{Rails.root}/app/api_views"
  wrap_parameters format: [:json]

  protect_from_forgery with: :null_session

  layout 'new_api/v2/layouts/json_layout'

  helper_method :passport
  helper 'new_api/v2/base'

  if Rails.env.production?
    rescue_from Exception, with: :error_occurred
  end

  protected
    def error_occurred(exception)
      error 500, exception.message
    end

end
