class AccessUserPolicy < ApplicationPolicy
  def update?
    user.can_lock_user?
  end
end
