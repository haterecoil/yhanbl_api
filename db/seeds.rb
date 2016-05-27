# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.delete_all
Message.delete_all

users = []
for i in 0..3 do
  username = 'User'+i.to_s
  password = 'aa'
  users.push(User.create({
    username: username
    }))
end


messages = []
for i in 0..5 do
  title = 'Message ' + i.to_s
  text = 'Message in the '+i.to_s+' bottle'
  sender = users[i%2]
  recipient = users[(i+1)%2]
  messages.push(Message.create({
    title: title,
    text: text,
    sent_on: Time.now,
    read_on: nil,
    answered_on: nil,
    sender: sender,
    recipient: recipient
    }))
end

