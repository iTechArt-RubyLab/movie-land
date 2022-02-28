class AddCanGiveRatingToPermissions < ActiveRecord::Migration[6.1]
  def change
    add_column :permissions, :can_give_rating, :boolean
  end
end
