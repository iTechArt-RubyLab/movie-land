class RemoveCanReadFromPermissions < ActiveRecord::Migration[6.1]
  def change
    safety_assured { remove_column :permissions, :can_read }
  end
end
