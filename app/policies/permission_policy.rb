class PermissionPolicy < ApplicationPolicy
  attr_reader :user, :record

  def show?
    user.can_edit_role?
  end

  def create?
    user.can_edit_role?
  end

  def update?
    user.can_edit_role?
  end

  def destroy?
    user.can_edit_role?
  end
end
