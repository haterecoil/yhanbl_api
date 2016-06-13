class MessagePolicy < ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    false unless user.is_admin
  end

  def show?
    scope.where(id: record.id).exists?
  end

  def create?
    return true if user.id == record.sender_id
    false
  end

  def new?
    create?
  end

  def set_read_messages?
    return true if user.is_admin
    scope.where(id: record.id).exists?
  end

  def set_rejected_messages?
    return true if user.is_admin
    scope.where(id: record.id).exists?
  end

  def update?
    return true if user.is_admin
    scope.where(id: record.id).exists?
  end

  def edit?
    update?
  end

  def destroy?
    return true if user.is_admin
    scope.where(id: record.id).exists?
  end

  def get_friends?
    return true if user.is_admin
    scope.where(id: record.id).exists?
  end

  def scope
    Pundit.policy_scope!(user, record.class)
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      if user.is_admin?
        scope.all
      elsif user
        scope.where(["sender_id = :user_id OR recipient_id = :user_id", {user_id: user.id}])
            .where(rejected_on: nil)
      else
        scope.none
      end
    end
  end
end
