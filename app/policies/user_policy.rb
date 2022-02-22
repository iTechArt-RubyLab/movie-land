class UserPolicy < ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    super(user)
    super(record)
  end

  def index?
    user.can_read?
  end

  def show?
    user.can_read?
  end

  def update?
    user.can_set_role?
  end

  def lock_user?
    user.can_lock_user?
  end

  def unlock_user?
    user.can_lock_user?
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
