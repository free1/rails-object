# source 'https://rubygems.org'
source 'https://ruby.taobao.org'

# ruby '2.1.2'
gem 'rails', '4.2.0'

# 登录
gem 'omniauth', '~> 1.2.1'
gem 'omniauth-weibo-oauth2', '~> 0.4.0'
gem 'omniauth-qq-connect'
gem 'omniauth-github'
gem 'omniauth-douban-oauth2'
# gem 'weibo_2' #api

# 样式
gem 'bootstrap-sass', '~> 3.2.0'
gem 'will_paginate-bootstrap'
gem 'autoprefixer-rails'

gem 'jquery-rails'
gem 'turbolinks'

gem 'net-ssh'

# api
gem 'grape'
gem 'grape-entity'
gem 'grape-swagger'
# gem 'swagger-ui_rails'  # 使用的jquery-1.8.0版本老
# 允跨域请求
gem 'rack-cors'

# redis
gem "redis", "~> 3.0.1"
gem "hiredis", "~> 0.4.5", :platforms => :ruby
gem 'redis-objects'

# 定时任务
gem 'whenever', :require => false

# 缓存
# gem 'dalli'
gem 'super_cache'

# 资源存储
gem 'qiniu', '~> 6.2.1'
gem "mime-types", '~> 1.19'

# 数据库
gem 'mysql2', '0.3.15'
# gem "mongoid", "~> 4.0.0"

# 搜索
# gem 'mysql2',          '~> 0.3.13', :platform => :ruby
gem 'jdbc-mysql',      '~> 5.1.28', :platform => :jruby
gem 'thinking-sphinx', '~> 3.1.0'

# 生成二维码
gem 'rqrcode_png'

# 表单
gem 'simple_form'
gem 'client_side_validations', :git => 'git@github.com:DavyJonesLocker/client_side_validations.git', :branch => '4-2-stable'
gem 'client_side_validations-simple_form', :git => 'git@github.com:DavyJonesLocker/client_side_validations-simple_form', :branch => '3-1-stable'

# 权限
gem 'cancancan', '~> 1.10'

# Simple Rails app configuration
gem "figaro"

# 分页
gem 'will_paginate', '~> 3.0.6'

# 加密链接id
# gem "obfuscate_id"

# web server
gem 'unicorn'

gem 'jbuilder', '~> 2.0'
gem 'rails-observers'
# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.7'

group :assets do
  gem 'sass-rails', '~> 4.0.3'
  gem 'uglifier', '>= 1.3.0'
  gem 'coffee-rails', '~> 4.0.0'
end

group :development do
  # 隐藏asset的log
  gem "quiet_assets", "~> 1.0.2"
  # model注释
  gem 'annotate', '~> 2.6.5'
  # 预加载器
  gem 'spring'
  # 部署
  gem 'capistrano', '~> 3.3.5'
  gem 'capistrano-bundler'
  gem 'capistrano-rails', '~> 1.1.0'
  gem 'capistrano-rbenv', "~> 2.0"
  gem 'capistrano3-unicorn'
  # 调试
  gem 'pry'
  gem 'pry-byebug'
  gem 'pry-rails'
end

# 爬虫
# gem 'free_spider'
gem 'nokogiri'

