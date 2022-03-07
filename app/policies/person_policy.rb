class PersonPolicy < ApplicationPolicy
  attr_reader :user, :record

  def index?
    user.can_read_person? || user.guest?
  end

  def show?
    user.can_read_person? || user.guest?
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
