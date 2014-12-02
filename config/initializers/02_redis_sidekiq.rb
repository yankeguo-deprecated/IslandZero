ENV['REDIS_PORT_6379_TCP_ADDR'] ||= '127.0.0.1'
ENV['REDIS_PORT_6379_TCP_PORT'] ||= '6379'

redis_url = "redis://#{ENV['REDIS_PORT_6379_TCP_ADDR']}:#{ENV['REDIS_PORT_6379_TCP_PORT']}"

# Shared redis instance

$redis = Redis.new({ url: "#{redis_url}/0", driver: :hiredis })

# Sidekiq

Sidekiq.configure_server do |config|
  config.redis = { url: "#{redis_url}/1" }
end

Sidekiq.configure_client do |config|
  config.redis = { url: "#{redis_url}/1" }
end
