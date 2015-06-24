# bundle exec sudo  god -c init.god -D

RAILS_ENV = 'production'
APP_ROOT = "/home/deploy/apps/weixin_test/current"

$stderr.puts("*" * 80)
$stderr.puts("Current environment is #{RAILS_ENV}")
$stderr.puts("*" * 80)

God.pid       = "/var/run/god.pid"
God.log_file  = "#{APP_ROOT}/log/god.log"
God.log_level = ((RAILS_ENV == 'production') ? :info : :debug)
 
%w(unicorn nginx redis).each do |config|
  God.load "#{APP_ROOT}/config/god/#{config}.god"
end