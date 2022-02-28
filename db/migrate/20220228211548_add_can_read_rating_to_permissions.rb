class AddCanReadRatingToPermissions < ActiveRecord::Migration[6.1]
  def change
    add_column :permissions, :can_read_rating, :boolean
  end
end
