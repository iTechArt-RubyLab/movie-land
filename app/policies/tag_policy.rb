class TagPolicy < ApplicationPolicy
  attr_reader :user, :record

  def index?
    user.can_read_entities?
  end
end
