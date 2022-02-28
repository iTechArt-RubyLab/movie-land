class AccessUserPolicy < ApplicationPolicy
  attr_reader :user, :record

  def update?
    user.can_lock_user?
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
