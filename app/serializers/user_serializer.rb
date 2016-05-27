class UserSerializer < ActiveModel::Serializer
  attributes :id,
      :username,
      :sent_messages,
      :received_messages
end
