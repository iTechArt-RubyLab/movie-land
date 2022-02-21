class CreateJoinTableCountriesMovies < ActiveRecord::Migration[6.1]
  def change
    create_join_table :countries, :movies do |t|
      t.index [:country_id, :movie_id], unique: true
      t.index [:movie_id, :country_id], unique: true
    end
  end
end
