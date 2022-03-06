class AddCanReadViewListToPermissions < ActiveRecord::Migration[6.1]
  def change
    add_column :permissions, :can_read_view_list, :boolean
  end
end
