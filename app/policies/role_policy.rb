class RolePolicy < ApplicationPolicy
  attr_reader :user, :record

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
