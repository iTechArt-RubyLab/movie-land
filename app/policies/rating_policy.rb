class RatingPolicy < ApplicationPolicy
  attr_reader :user, :record

  def index?
    user.can_read_rating?
  end

  def create?
    user.can_give_rating?
  end

  def update?
    user.can_give_rating?
  end

  def destroy?
    user.can_give_rating?
  end
end
