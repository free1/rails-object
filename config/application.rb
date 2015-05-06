require File.expand_path('../boot', __FILE__)

require 'rails/all'
# require "action_controller/railtie"
# require "action_mailer/railtie"
# require "active_resource/railtie" # Comment this line for Rails 4.0+
# require "rails/test_unit/railtie"
# require "sprockets/railtie" # Uncomment this line for Rails 3.1+

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module WeixinTest
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    # config.active_record.default_timezone = :local
    config.time_zone = 'Beijing'
    # api
    config.paths.add File.join('app', 'api'), :glob => File.join('**', '*.rb')
    config.autoload_paths += Dir[Rails.root.join('app', 'api', '*')]

    config.autoload_paths += Dir["#{config.root}/app/controllers/concerns", "#{config.root}/app/models/concerns"]

    # Observer configuration
    config.active_record.observers = :user_observer

    # 生成器设置
    config.generators do |g|
      g.orm             :active_record
      g.stylesheets     false
      g.helper          false
      g.test_framework  nil
    end

    # api文档资源
    # config.assets.precompile += %w(api_swagger_ui/reset.css api_swagger_ui/screen.css)
    # config.assets.precompile += %w(api_swagger_ui/backbone-min.js api_swagger_ui/handlebars-1.js
    #                                 api_swagger_ui/highlight.js api_swagger_ui/jquery-1.js
    #                                 api_swagger_ui/jquery.js api_swagger_ui/jquery_002.js
    #                                 api_swagger_ui/jquery_003.js api_swagger_ui/shred.js
    #                                 api_swagger_ui/swagger-client.js api_swagger_ui/swagger-oauth.js
    #                                 api_swagger_ui/swagger-ui.js api_swagger_ui/swagger.js
    #                                 api_swagger_ui/underscore-min.js)
    config.assets.precompile += %w(doc/*.css api_swagger_ui/swagger-ui_rails.*)
    config.assets.precompile += %w(upload/*.js doc/*.js)

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de
    config.exceptions_app = self.routes
  end
end
