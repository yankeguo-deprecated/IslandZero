Rails.application.configure do
  method = ENV['MAILER_METHOD']

  config.action_mailer.default_url_options = { 
    :host => ENV['MAILER_HOST'] 
  }

  config.action_mailer.delivery_method = method

  if method == 'smtp'
    config.action_mailer.smtp_settings = {
      address:      ENV['MAILER_SMTP_SERVER'],
      port:         ENV['MAILER_SMTP_PORT'],
      user_name:    ENV["MAILER_SMTP_USERNAME"],
      password:     ENV["MAILER_SMTP_PASSWORD"],
      authentication: "plain",
      enable_starttls_auto: true
    }
  end

end
