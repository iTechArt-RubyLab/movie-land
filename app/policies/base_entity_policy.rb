class BaseEntityPolicy < ApplicationPolicy
  def index?
    user.can_read_entities?
  end

  def create?
    user.can_edit_entities?
  end

  def update?
    user.can_edit_entities?
  end

  def destroy?
    user.can_edit_entities?
  end
end
