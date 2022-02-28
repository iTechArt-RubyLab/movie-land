class AddCanReadMovieToPermissions < ActiveRecord::Migration[6.1]
  def change
    add_column :permissions, :can_read_movie, :boolean
  end
end
