class RolePolicy < ApplicationPolicy
  def index?
    user.can_edit_role?
  end

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
