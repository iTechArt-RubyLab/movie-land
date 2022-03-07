class ViewListPolicy < ApplicationPolicy
  attr_reader :user, :record

  def index?
    user.can_read_view_list?
  end

  def create?
    user.can_edit_view_list?
  end

  def update?
    user.can_edit_view_list?
  end

  def destroy?
    user.can_edit_view_list?
  end
end
