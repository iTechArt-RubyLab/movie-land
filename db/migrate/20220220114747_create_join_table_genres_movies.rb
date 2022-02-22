class CreateJoinTableGenresMovies < ActiveRecord::Migration[6.1]
  def change
    create_join_table :genres, :movies do |t|
      t.index [:genre_id, :movie_id], unique: true
      t.index [:movie_id, :genre_id], unique: true
    end
  end
end
