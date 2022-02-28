class AddCanEditPermissionToPermissions < ActiveRecord::Migration[6.1]
  def change
    add_column :permissions, :can_edit_permission, :boolean
  end
end
