# thecore_backend_commons's after_initialize loads thecore_auth_commons's User model, whose class
# body calls `devise`: that method only exists once Devise's ActiveRecord ORM adapter is loaded,
# which a real app does in its generated devise initializer. Same minimal initializer as mytask's
# own dummy app (test/dummy/config/initializers/devise.rb).
Devise.setup do |config|
  config.mailer_sender = 'test@example.com'
  require 'devise/orm/active_record'
  config.case_insensitive_keys = [:email]
  config.strip_whitespace_keys = [:email]
  config.skip_session_storage = [:http_auth]
  config.stretches = Rails.env.test? ? 1 : 12
  config.reconfirmable = false
  config.expire_all_remember_me_on_sign_out = true
  config.password_length = 8..128
  config.email_regexp = /\A[^@\s]+@[^@\s]+\z/
  config.reset_password_within = 6.hours
  config.sign_out_via = :delete
  config.responder.error_status = :unprocessable_entity
  config.responder.redirect_status = :see_other
end
