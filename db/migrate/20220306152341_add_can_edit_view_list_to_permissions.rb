class AddCanEditViewListToPermissions < ActiveRecord::Migration[6.1]
  def change
    add_column :permissions, :can_edit_view_list, :boolean
  end
end
