class TagPolicy < ApplicationPolicy
  def index?
    user.can_read_entities?
  end
end
