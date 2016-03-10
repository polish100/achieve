# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#User.create(:email => 'k_ikeda@gameon.co.jp', :name => 'test', :profile => 'test')
#User.create(email: 'k_ikeda@gameon.co.jp',name: 'test',profile: 'test')
# coding: utf-8
1000.times do |i|

user = User.new(name: "ユーザ#{i}", email: "#{i}@dicachieve.co.jp", password: "password#{i}", uid: "#{i}")
user.skip_confirmation!
user.save!
Blog.create(title: "title#{i}",content: "content#{i}",user_id: user.id)

end