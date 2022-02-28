class AddCanEditMovieToPermissions < ActiveRecord::Migration[6.1]
  def change
    add_column :permissions, :can_edit_movie, :boolean
  end
end
