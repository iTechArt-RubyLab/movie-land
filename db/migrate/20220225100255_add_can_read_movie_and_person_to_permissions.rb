class AddCanReadMovieAndPersonToPermissions < ActiveRecord::Migration[6.1]
  def change
    add_column :permissions, :can_read_movie_and_person, :boolean
  end
end
