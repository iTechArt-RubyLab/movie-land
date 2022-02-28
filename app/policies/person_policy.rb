class PersonPolicy < ApplicationPolicy
  attr_reader :user, :record

  def index?
    user.can_read_movie_and_person?
  end

  def show?
    user.can_read_movie_and_person?
  end

  def create?
    user.can_edit_movie_and_person?
  end

  def update?
    user.can_edit_movie_and_person?
  end

  def destroy?
    user.can_edit_movie_and_person?
  end
end
