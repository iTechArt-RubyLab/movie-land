class AddCanUseSearchToPermissions < ActiveRecord::Migration[6.1]
  def change
    add_column :permissions, :can_use_search, :boolean
  end
end
