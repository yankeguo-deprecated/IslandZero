source 'https://rubygems.org'

# Rails

gem 'rails', '4.1.4'
gem 'rails-i18n'
gem 'sass-rails', '~> 4.0.3'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'jquery-rails'
gem 'turbolinks'
gem 'jbuilder', '~> 2.0'
gem 'http_accept_language'
gem 'faye-rails'
gem 'sanitize', '~> 2.0'
gem 'faker'
gem 'will_paginate', '~> 3.0.6'
gem 'redcarpet'
gem 'mailgun_rails'

# Redis

gem "redis", "~> 3.0.1"
gem "hiredis", "~> 0.4.5"

gem 'sidekiq'
gem 'sinatra', '>= 1.3.0', :require => nil # No require, no DSL

# Devise

gem 'devise'
gem 'devise-i18n'
gem 'devise-async'

# Engine

gem 'thin'

# Configuration Manager

gem "figaro"

# Monitor

gem 'newrelic_rpm'

# Environment specified

group :production do
  # MySQL
  gem 'mysql2'
end

group :development, :test do
  # Sqlite3
  gem 'sqlite3'

  # Deployment
  gem 'capistrano',  '~> 3.1'
  gem 'capistrano-bundler', '~> 1.1.2'
  gem 'capistrano-rails', '~> 1.1'
  gem 'capistrano-rvm'
  gem 'capistrano-sidekiq'

  # Document
  gem 'yard'

  # i18n
  gem 'i18n-debug'

  # Test
  gem 'rspec-rails', '~> 3.0'
end
