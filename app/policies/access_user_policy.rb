class AccessUserPolicy < ApplicationPolicy
  attr_reader :user, :record

  def update?
    user.can_lock_user?
  end
end
