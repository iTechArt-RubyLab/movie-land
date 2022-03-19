class SearchPolicy < ApplicationPolicy
  attr_reader :user, :record

  def index?
    user.can_use_search?
  end
end
