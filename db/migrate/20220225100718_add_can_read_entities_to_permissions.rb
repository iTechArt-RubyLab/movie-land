class AddCanReadEntitiesToPermissions < ActiveRecord::Migration[6.1]
  def change
    add_column :permissions, :can_read_entities, :boolean
  end
end
