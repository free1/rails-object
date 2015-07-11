class NewApi::V2::BaseController < ActionController::Metal

  # 加载顺序不能变
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

  include Rails.application.routes.url_helpers

  append_view_path "#{Rails.root}/app/views/api/v2"
  wrap_parameters format: [:json]

  protect_from_forgery with: :null_session

  layout 'layouts/json_layout'

  helper_method :passport
  helper 'new_api/v2/base'

end
