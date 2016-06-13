class MessageSerializer < ActiveModel::Serializer
  attributes :id,
      :title,
      :text,
      :sent_on,
      :received_on,
      :opened_on,
      :answered_on,
      :rejected_on,
      :picture

  has_one :recipient
  has_one :sender

  def recipient
      # return object.recipient if @current_user.is_admin?
      attributes["recipient"] = {"username" => object.recipient.username, "id" => object.recipient.id}
  end
  def sender
      # return object.sender if @current_user.is_admin?
      attributes["sender"] = {"username" => object.sender.username, "id" => object.sender.id}
  end


end
