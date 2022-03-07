class MoviePolicy < ApplicationPolicy
  attr_reader :user, :record

  def index?
    user.can_read_movie? || user.guest?
  end

  def show?
    user.can_read_movie? || user.guest?
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
