# Mailer Configurations

Figaro.require_keys(
"MAILER_HOST",
'MAILER_METHOD'
)

if ENV['MAILER_METHOD'] == 'smtp'
  Figaro.require_keys(
  "MAILER_SMTP_SERVER",
  "MAILER_SMTP_PORT",
  "MAILER_SMTP_USERNAME",
  "MAILER_SMTP_PASSWORD"
  )
end
