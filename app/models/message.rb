class Message < ActiveRecord::Base

  before_create :add_recipient

  belongs_to :sender, class_name: "User"
  belongs_to :recipient, class_name: "User"

  scope :for_user, -> (user) {
    where(["sender_id = :user_id OR recipient_id = :user_id", {user_id: user.id}])
  }

  private

    def add_recipient
      self.recipient = get_another_user(self.sender)
    end

    def get_another_user(current_user)

      current_user_id = current_user.id
      user_count = User.count
      found_user = nil

      until found_user
        rand_id = rand(user_count)+1

        found_user = User.where(id: rand_id).first
        found_user = false if rand_id == current_user_id
      end

      found_user
    end
end
