require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Magi
  class Application < Rails::Application
    # Autoload lib fonder
    config.autoload_paths << Rails.root.join('lib')

    # Mailer

    ENV['MAILER_METHOD']    ||= 'sendmail'
    ENV['MAILER_HOST']      ||= 'localhost:3000'
    ENV['MAILER_PROTOCOL']  ||= 'http'

    config.action_mailer.default_url_options = {
      :host =>     ENV['MAILER_HOST'],
      :protocol => ENV['MAILER_PROTOCOL']
    }

    # to_sym is important
    config.action_mailer.delivery_method = ENV['MAILER_METHOD'].to_sym

    if ENV['MAILER_METHOD'] == 'smtp'
      config.action_mailer.smtp_settings = {
        address:      ENV['MAILER_SMTP_SERVER'],
        port:         ENV['MAILER_SMTP_PORT'],
        user_name:    ENV["MAILER_SMTP_USERNAME"],
        password:     ENV["MAILER_SMTP_PASSWORD"],
        authentication: "plain",
        enable_starttls_auto: true
      }
    end

    if ENV['MAILER_METHOD'] == 'mailgun'
      config.action_mailer.mailgun_settings = {
        api_key: ENV['MAILGUN_API_KEY'],
        domain:  ENV['MAILGUN_DOMAIN']
      }
    end
  end
end
