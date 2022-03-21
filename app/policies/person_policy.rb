class PersonPolicy < ApplicationPolicy
  def index?
    user.can_read_person?
  end

  def show?
    user.can_read_person?
  end

  def create?
    user.can_edit_person?
  end

  def update?
    user.can_edit_person?
  end

  def destroy?
    user.can_edit_person?
  end
end
