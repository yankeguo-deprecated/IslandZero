Sidekiq.configure_server do |config|
  config.redis = { url: "#{ENV['REDIS_URL']}/10" }
end
