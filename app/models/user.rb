class User < ActiveRecord::Base
  has_many :sent_messages, class_name: "Message", foreign_key: "sender_id"
  has_many :received_messages, class_name: "Message", foreign_key: "recipient_id"

  scope :friends_of, -> (user) {
    # find users where message is sent to user
    joins("INNER JOIN messages ON users.id = messages.recipient_id OR users.id = messages.sender_id")
        .where(["users.id != ? AND (messages.recipient_id = ? OR messages.sender_id = ?)", user.id, user.id, user.id])
        .group(:id)
  }

  # SELECT users.username, users.id, messages.title, messages.sender_id, messages.recipient_id from users
  # INNER JOIN messages
  #   ON users.id = messages.recipient_id OR users.id = messages.sender_id
  # WHERE messages.recipient_id = 1 OR messages.sender_id = 1
  # GROUP BY users.id

end
