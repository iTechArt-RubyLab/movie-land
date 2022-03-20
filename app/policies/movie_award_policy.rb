class MovieAwardPolicy < ApplicationPolicy
  def index?
    user.can_read_award?
  end

  def show?
    user.can_read_award?
  end

  def create?
    user.can_edit_award?
  end

  def update?
    user.can_edit_award?
  end

  def destroy?
    user.can_edit_award?
  end
end
