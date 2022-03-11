class AddCanLeaveCommentToPermissions < ActiveRecord::Migration[6.1]
  def change
    add_column :permissions, :can_leave_comment, :boolean
  end
end
