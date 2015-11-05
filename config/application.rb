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
    # emoji
    config.assets.paths << Emoji.images_path

    config.autoload_paths += %W(#{config.root}/lib)

    # Observer configuration
    config.active_record.observers = [:user_observer, :comment_observer]

    # 生成器设置
    config.generators do |g|
      g.orm             :active_record
      g.stylesheets     false
      g.helper          false
      g.test_framework  nil
    end

    # 中间件
    config.middleware.delete 'Rack::Lock'
    # config.middleware.use Rack::ApiAuth

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de
    config.exceptions_app = self.routes

    # config.action_controller.include_all_helpers = false
  end
end
