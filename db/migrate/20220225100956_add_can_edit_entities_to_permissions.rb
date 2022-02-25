class AddCanEditEntitiesToPermissions < ActiveRecord::Migration[6.1]
  def change
    add_column :permissions, :can_edit_entities, :boolean
  end
end
