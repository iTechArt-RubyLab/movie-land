class UserPolicy < ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    super(user)
    super(record)
  end

  def index?
    user.role.can_read?
  end

  def show?
    user.role.can_read?
  end

  def update?
    user.role.can_set_role?
  end

  def lock_user?
    user.role.can_lock_user?
  end

  def unlock_user?
    user.role.can_lock_user?
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
