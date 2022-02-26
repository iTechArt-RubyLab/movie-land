class RemoveCanEditFromPermissions < ActiveRecord::Migration[6.1]
  def change
    safety_assured { remove_column :permissions, :can_edit }
  end
end
