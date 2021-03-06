# source 'https://rubygems.org'
source 'https://ruby.taobao.org'

# ruby '2.1.2'
gem 'rails', '4.2.5'
# 解决服务器没有安装readline问题
gem 'rb-readline'

# 登录
gem 'omniauth', '~> 1.2.1'
gem 'omniauth-weibo-oauth2', '~> 0.4.0'
gem 'omniauth-qq-connect'
gem 'omniauth-github'
gem 'omniauth-douban-oauth2'
gem 'omniauth-open_wechat', :git => 'https://github.com/free1/omniauth-open_wechat.git'
gem "omniauth-wechat-oauth2"
# gem 'weibo_2' #api

# 样式
gem 'bootstrap-sass', '~> 3.2.0'
gem 'will_paginate-bootstrap'
gem 'autoprefixer-rails'
# gem 'foundation-rails', "~> 5.5.2.1"
# gem 'foundation-icons-sass-rails'

gem 'jquery-rails'
gem 'turbolinks'

gem 'net-ssh'

# 前端自动化暂时使用rails作为服务器
gem "browserify-rails"

# html文本处理
gem 'html-pipeline', "~> 1.11.0" # 之前版本有bug
gem 'gemoji'
gem "rinku", "~> 1.7",   :require => false

# @功能
gem 'jquery-atwho-rails', "~> 1.1.0"

# 动态消息feed
gem 'public_activity', '~> 1.4.2'

# 实时刷新消息数量
gem 'message_bus', '~> 1.0.9'  # faye不支持WEBrick

# api
gem 'grape'
gem 'grape-entity'
gem 'grape-swagger'
gem 'swagger-ui_rails'  # 使用的jquery-1.8.0版本老
# 允跨域请求
gem 'rack-cors'

# redis
gem "redis", "~> 3.0.1"
gem "hiredis", "~> 0.4.5", :platforms => :ruby
gem 'redis-objects'
gem 'redis-stat'       # redis-stat --server 

# 定时任务
gem 'whenever', :require => false

# 后台任务
gem 'sidekiq'

# 缓存
# gem 'dalli'
gem 'super_cache'

# 资源存储
gem 'qiniu', '~> 6.2.1'
gem "mime-types", '~> 1.19'

# 数据库
# gem 'mysql2', '0.3.15'
gem 'mysql2', '>= 0.3.13', '< 0.5'
# gem "mongoid", "~> 4.0.0"

# 搜索
# gem 'mysql2',          '~> 0.3.13', :platform => :ruby
# gem 'jdbc-mysql',      '~> 5.1.28', :platform => :jruby
# gem 'thinking-sphinx', '~> 3.1.0'
# gem 'sunspot_rails'  # bundle exec rake sunspot:solr:start
# gem 'sunspot_solr' # optional pre-packaged Solr distribution for use in development
# gem 'progress_bar'  # 解决sunspot的index时 default: http://ip:8983/solr/#/
gem 'elasticsearch', git: 'git://github.com/elasticsearch/elasticsearch-ruby.git'
gem 'elasticsearch-model', git: 'git://github.com/elasticsearch/elasticsearch-rails.git'
gem 'elasticsearch-rails', git: 'git://github.com/elasticsearch/elasticsearch-rails.git'

# 生成二维码
gem 'rqrcode_png'

# 验证码
# gem 'negative_captcha'   #不需要手动输入验证码就可以防止机器注册，但不支持simple-form
# gem 'humanizer', '~> 2.6.2'
gem 'invisible_captcha', '~> 0.8.0'

# 表单
gem 'simple_form'
gem 'client_side_validations', :github => 'free1/client_side_validations', :branch => '4-2-stable'
gem 'client_side_validations-simple_form', :github => 'free1/client_side_validations-simple_form', :branch => '3-1-stable'
# gem 'client_side_validations', :git => 'git@github.com:DavyJonesLocker/client_side_validations.git', :branch => '4-2-stable'
# gem 'client_side_validations-simple_form', :git => 'git@github.com:DavyJonesLocker/client_side_validations-simple_form', :branch => '3-1-stable'

# 权限
gem 'cancancan', '~> 1.10'

# Simple Rails app configuration
gem "figaro"

# 分页
gem 'will_paginate', '~> 3.0.6'

# 加密链接id
# gem "obfuscate_id"
gem 'friendly_id', '~> 5.1.0'
# 汉字转换拼音
gem 'ruby-pinyin'
# 加密api
gem 'jwt', '~> 1.4.1'

# 监控
gem 'god'
gem 'newrelic_rpm'

# web server
gem 'unicorn', '~> 4.8.3'

# 备份(直接上传阿里云oos)
gem 'backup'
# gem 'rest-client'
# gem 'carrierwave-aliyun'

gem 'jbuilder', '~> 2.0'
# 观察者
gem 'rails-observers'
# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.7'

# 短信
gem 'china_sms'

# github的api
gem 'octokit'

# 支付
gem 'activemerchant', "1.43.3", :require => 'active_merchant'
gem 'aasm'
# 跟踪obj状态
gem 'paper_trail', '~> 3.0.6'

# admin
gem 'inherited_resources'

group :assets do
  gem 'sass-rails', '~> 5.0'
  gem 'uglifier', '>= 1.3.0'
  gem 'coffee-rails', '~> 4.0.0'
end

group :development do
  # 隐藏asset的log
  gem "quiet_assets", "~> 1.0.2"
  # model注释
  gem 'annotate', '~> 2.6.6'
  # 预加载器
  gem 'spring', '~> 1.3.6'
  # 部署
  gem 'capistrano', '~> 3.3.5'
  gem 'capistrano-bundler'
  gem 'capistrano-rails', '~> 1.1.3'
  gem 'capistrano-rbenv', "~> 2.0"
  gem 'capistrano3-unicorn'
  gem 'capistrano-sidekiq'
  gem 'capistrano-npm'
  # 调试
  gem 'pry'
  gem 'pry-byebug'
  gem 'pry-rails'
  # gem 'pry-rails'  # 中文有乱码问题
  # 性能检测
  gem "bullet"
  gem "uniform_notifier", require: false
end

# 爬虫
# gem 'free_spider'
gem 'nokogiri'

