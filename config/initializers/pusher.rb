require 'pusher'

Pusher.app_id = ENV['PUSHER_APP_ID']
Pusher.key = ENV['PUSHER_ACCESS_KEY']
Pusher.secret = ENV['PUSHER_ACCESS_KEY_SECERT']
Pusher.logger = ENV['PUSHER_APP_ID']
Pusher.encrypted = true

Pusher.url = "https://4369b80e9ca90ea62e58:97ac02fd43484f8d1133@api.pusherapp.com/apps/144559"
Pusher.logger = Rails.logger

# app/controllers/hello_world_controller.rb
class HelloWorldController < ApplicationController
  def hello_world
    Pusher.trigger('test_channel', 'my_event', {
      message: 'hello world'
    })
  end
end
