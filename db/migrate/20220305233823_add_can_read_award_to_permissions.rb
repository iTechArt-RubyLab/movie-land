class AddCanReadAwardToPermissions < ActiveRecord::Migration[6.1]
  def change
    add_column :permissions, :can_read_award, :boolean
  end
end
