class SearchPolicy < ApplicationPolicy
  def index?
    user.can_use_search?
  end
end
