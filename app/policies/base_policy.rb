class BasePolicy < ApplicationPolicy
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

  def create?
    user.role.can_edit?
  end

  def update?
    user.role.can_edit?
  end

  def destroy?
    user.role.can_edit?
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
