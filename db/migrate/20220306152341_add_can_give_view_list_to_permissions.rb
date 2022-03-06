class AddCanGiveViewListToPermissions < ActiveRecord::Migration[6.1]
  def change
    add_column :permissions, :can_give_view_list, :boolean
  end
end
