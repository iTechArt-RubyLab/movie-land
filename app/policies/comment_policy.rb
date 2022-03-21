class CommentPolicy < ApplicationPolicy
  def create?
    user.can_leave_comment?
  end

  def update?
    user.can_leave_comment?
  end

  def destroy?
    user.can_leave_comment?
  end
end
