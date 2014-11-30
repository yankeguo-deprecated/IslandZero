# Production Only
if Rails.env.production?
  # Secret Key Base
  Figaro.require_keys 'SECRET_KEY_BASE'
  # MySQL
  Figaro.require_keys 'MYSQL_USERNAME', 'MYSQL_PASSWORD', 'MYSQL_SOCKET', 'MYSQL_DATABASE'
end

# Mailer Configurations
Figaro.require_keys "MAILER_HOST", 'MAILER_METHOD', 'MAILER_PROTOCOL'

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
