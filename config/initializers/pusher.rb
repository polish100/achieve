require 'pusher'

Pusher.app_id = ENV['PUSHER_APP_ID']
Pusher.key = ENV['PUSHER_ACCESS_KEY']
Pusher.secret = ENV['PUSHER_ACCESS_KEY_SECERT']
Pusher.logger = ENV['PUSHER_APP_ID']
Pusher.encrypted = true
