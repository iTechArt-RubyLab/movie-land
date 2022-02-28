class AddCanEditPersonToPermissions < ActiveRecord::Migration[6.1]
  def change
    add_column :permissions, :can_edit_person, :boolean
  end
end
