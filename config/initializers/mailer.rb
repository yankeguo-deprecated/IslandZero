method = ENV['MAILER_METHOD']

Rails.application.configure do
  config.action_mailer.default_url_options = { :host => ENV['MAILER_HOST'] }
  config.action_mailer.delivery_method = ENV['MAILER_METHOD']

  if config.action_mailer.delivery_method == 'smtp'
    config.action_mailer.smtp_settings = {
      address:  ENV['MAILER_SMTP_SERVER'],
      port:     ENV['MAILER_SMTP_PORT'],
      authentication: "plain",
      enable_starttls_auto: true,
      user_name:  ENV["MAILER_SMTP_USERNAME"],
      password:   ENV["MAILER_SMTP_PASSWORD"]
    }
  end
end
