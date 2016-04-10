# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

Rails.application.config.assets.paths << Rails.root.join('app', 'assets', 'fonts')
Rails.application.config.assets.paths << Rails.root.join('app', 'assets', 'fonts', 'mobile')
Rails.application.config.assets.precompile << /\.(?:svg|eot|woff|ttf)\z/
# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )
Rails.application.config.assets.precompile += %w( mobile_application.js )
Rails.application.config.assets.precompile += %w( mobile_application.css )

Rails.application.config.assets.precompile += %w(doc/*.css api_swagger_ui/swagger-ui_rails.*)
Rails.application.config.assets.precompile += %w(upload/*.js doc/*.js)
Rails.application.config.assets.precompile += %w(tools/*.js)
Rails.application.config.assets.precompile << "emoji/**/*.png"
Rails.application.config.assets.precompile << %w(single/*.css)