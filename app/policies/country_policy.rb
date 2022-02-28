class CountryPolicy < ApplicationPolicy
  attr_reader :user, :record

  def index?
    user.can_read_entities?
  end

  def show?
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

  class Scope
    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      scope.all
    end

    private

    attr_reader :user, :scope
  end
end
