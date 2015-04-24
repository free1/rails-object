# -*- encoding : utf-8 -*-
require "redis"
# require "redis-namespace"
require "redis/objects"

if Rails.env.production?
  redis_configuration = {host: ENV['redis_host'],
                        port: ENV['redis_port'], 
                        password: ENV['redis_password']}
  #redis-objects-config
  $redis = Redis::Objects.redis = Redis.new(redis_configuration)
else
  redis_configuration = {host: 'localhost', port: 6379}
  $redis = Redis::Objects.redis = Redis.new(redis_configuration)
end
