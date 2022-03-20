class MoviePolicy < ApplicationPolicy
  def index?
    user.can_read_movie?
  end

  def show?
    user.can_read_movie?
  end

  def create?
    user.can_edit_movie?
  end

  def update?
    user.can_edit_movie?
  end

  def destroy?
    user.can_edit_movie?
  end
end
