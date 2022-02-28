class AddCanReadPersonToPermissions < ActiveRecord::Migration[6.1]
  def change
    add_column :permissions, :can_read_person, :boolean
  end
end
