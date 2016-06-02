class MessageSerializer < ActiveModel::Serializer
  attributes :id,
      :title,
      :text,
      :sent_on,
      :read_on,
      :answered_on,
      :sender,
      :recipient
      #:sent_messages,
      #:received_messages
end
