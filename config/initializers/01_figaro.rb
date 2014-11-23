# Secret Key Base (Production Only)
if Rails.env.production?
  Figaro.require_keys 'SECRET_KEY_BASE'
end

# Mailer Configurations
Figaro.require_keys "MAILER_HOST", 'MAILER_METHOD'

if ENV['MAILER_METHOD'] == 'smtp'
  Figaro.require_keys(
  "MAILER_SMTP_SERVER",
  "MAILER_SMTP_PORT",
  "MAILER_SMTP_USERNAME",
  "MAILER_SMTP_PASSWORD"
  )
end

# Timezone
Figaro.require_keys 'TIMEZONE'

# Redis
Figaro.require_keys 'REDIS_URL'
