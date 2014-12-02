source 'https://rubygems.org'

# Rails

gem 'rails', '4.1.4'
gem 'rails-i18n', '~> 4.0'
gem 'sass-rails', '~> 4.0.3'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'jquery-rails', '~> 3.1.2'
gem 'turbolinks',   '~> 2.5.2'
gem 'jbuilder', '~> 2.0'
gem 'http_accept_language', '~> 2.0.2'
gem 'faye-rails', '~> 2.0'
gem 'sanitize', '~> 2.0'
gem 'faker',    '~> 1.4.3'
gem 'will_paginate', '~> 3.0.6'
gem 'redcarpet',     '~> 3.2.1'
gem 'mailgun_rails', '~> 0.6.4'

# Redis

gem "redis", "~> 3.0.1"
gem "hiredis", "~> 0.4.5"

gem 'sidekiq', '~> 3.3.0'
gem 'sinatra', '>= 1.3.0', :require => nil # No require, no DSL

# Devise

gem 'devise'     , '~> 3.4.1'
gem 'devise-i18n', '~> 0.11.2'
gem 'devise-async','~> 0.9.0'

# Engine

gem 'thin'

# Configuration Manager

gem "figaro",   '~> 1.0.0'

# Monitor

gem 'newrelic_rpm'

# Environment specified

group :production do
  # MySQL
  gem 'mysql2', '~> 0.3.17'
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
