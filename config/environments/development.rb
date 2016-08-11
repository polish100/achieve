Rails.application.configure do

  require 'pusher'
  app_id = "234845"
  key = "7dd89f883d4189c41720"
  secret = "d853adc5d96610bf6a09"

  config.cache_classes = false

  config.eager_load = false

  config.consider_all_requests_local       = true
#  config.consider_all_requests_local       = true

  config.action_controller.perform_caching = false
  #config.action_mailer.raise_delivery_errors = false

  config.active_support.deprecation = :log

  config.active_record.migration_error = :page_load


  config.assets.debug = true

  config.assets.digest = true

  config.assets.raise_runtime_errors = true


  #deviseの設定
  config.action_mailer.default_url_options = { host: 'localhost:3000' }
  #config.action_mailer.default_url_options = { host: 'pj-dic-150006.nitrousapp.com:3000' }

  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
  :enable_starttls_auto => true,
  :address => "smtp.gmail.com",
  :port => 587,
  :domain => 'smtp.gmail.com',
  :authentication => :login,
  :user_name => ENV["GMAIL_ADDRESS"], #gmailアドレス
  :password => ENV["GMAIL_PASSWORD"], #gmailパスワード
}

  BetterErrors::Middleware.allow_ip! '54.251.49.8'
end
