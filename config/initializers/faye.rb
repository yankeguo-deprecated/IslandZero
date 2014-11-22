Rails.application.configure do
  # Remove Rack::Lock to enable Faye
  config.middleware.delete Rack::Lock
  # Enable Middleware
  config.middleware.use FayeRails::Middleware, mount: '/faye', :timeout => 25
end
