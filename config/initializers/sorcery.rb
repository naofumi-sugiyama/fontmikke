Rails.application.config.sorcery.submodules = [:reset_password]

Rails.application.config.sorcery.configure do |config|
  config.user_config do |user|
    user.stretches = 1 if Rails.env.test?

    user.reset_password_mailer = UserMailer
    user.reset_password_time_between_emails = 5 * 60

    user.reset_password_expiration_period = 24.hours
  end

  config.user_class = "User"
end