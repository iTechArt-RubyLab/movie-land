class UserPolicy < ApplicationPolicy
  attr_reader :user, :record

  def index?
    user.predefined_user?
  end

  def show?
    user.predefined_user?
  end

  def update?
    user.can_set_role?
  end

  class Scope
    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      user.admin? ? scope.all : scope.where(locked_at: nil)
    end

    private

    attr_reader :user, :scope
  end
end
