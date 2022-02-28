class PermissionPolicy < ApplicationPolicy
  attr_reader :user, :record

  def show?
    user.can_edit_permission?
  end

  def create?
    user.can_edit_permission?
  end

  def update?
    user.can_edit_permission?
  end

  def destroy?
    user.can_edit_permission?
  end
end
