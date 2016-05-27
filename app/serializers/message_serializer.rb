class MessageSerializer < ActiveModel::Serializer
  attributes :id,
      :title,
      :text,
      :sent_on,
      :read_on,
      :answered_on,
      :sent_messages,
      :received_messages
end
