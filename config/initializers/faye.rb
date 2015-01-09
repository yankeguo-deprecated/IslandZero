Rails.application.configure do
  # Remove Rack::Lock to enable Faye
  config.middleware.delete Rack::Lock
  # Enable Middleware
  config.middleware.use FayeRails::Middleware, mount: '/faye', engine: { type: Faye::Redis, host: ENV['REDIS_PORT_6379_TCP_ADDR'], port: ENV['REDIS_PORT_6379_TCP_PORT'].to_i }, :timeout => 25 do
    map '/chat/**' => RealtimeChatController
    map :default => :block
  end
end
