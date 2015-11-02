require "redis"

if Rails.env.production?
    redis_configuration = {host: ENV['redis_host'], port: ENV['redis_port']}
                        # password: ENV['redis_password']}
else
    redis_configuration = {host: 'localhost', port: 6379}
end

redis_conn = proc {
  Redis.new(redis_configuration)
}

Sidekiq.configure_client do |config|
  config.redis = ConnectionPool.new(size: 5, &redis_conn)
end
Sidekiq.configure_server do |config|
  config.redis = ConnectionPool.new(size: 25, &redis_conn)
end