class TagPolicy < ApplicationPolicy
  attr_reader :user, :record

  def index?
    user.can_read_entities?
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
