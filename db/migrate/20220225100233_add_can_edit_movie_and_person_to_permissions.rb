class AddCanEditMovieAndPersonToPermissions < ActiveRecord::Migration[6.1]
  def change
    add_column :permissions, :can_edit_movie_and_person, :boolean
  end
end
