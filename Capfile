require 'capistrano/setup'
require 'capistrano/deploy'
require 'capistrano/rails'
require 'capistrano/rvm'
require 'capistrano/thin'
require 'capistrano/sidekiq'

# Load Rails Environment so we have Figaro
require File.expand_path('../config/environment',  __FILE__)

Dir.glob('lib/capistrano/tasks/*.rake').each { |r| import r }
