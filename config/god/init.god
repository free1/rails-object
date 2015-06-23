rails_env = 'production'
rails_root = "/home/deploy/apps/weixin_test/current"

$stderr.puts("*" * 80)
$stderr.puts("Current environment is #{rails_env}")
$stderr.puts("*" * 80)

God.pid       = "/var/run/god.pid"
God.log_file  = "#{rails_root}/log/god.log"
God.log_level = ((rails_env == 'production') ? :info : :debug)
 
%w(unicorn nginx redis).each do |config|
  God.load "#{APP_ROOT}/config/god/#{config}.god"
end