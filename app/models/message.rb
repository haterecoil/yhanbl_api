class Message < ActiveRecord::Base

  mount_uploader :picture, PictureUploader

  before_create :add_recipient

  belongs_to :sender, class_name: "User"
  belongs_to :recipient, class_name: "User"

  scope :for_user, -> (user) {
    where(["sender_id = :user_id OR recipient_id = :user_id", {user_id: user.id}])
  }

  private

    def add_recipient
      if (self.recipient.nil?)
        self.recipient = get_another_user(self.sender)
      end
    end

    def get_another_user(current_user)

      current_user_id = current_user.id
      first_user_id = User.first.id
      user_count = User.count
      found_user = false

      until found_user
        rand_id = rand(user_count)+first_user_id

        found_user = User.where(id: rand_id).first
        found_user = false if rand_id == current_user_id
      end

      found_user
    end


end
