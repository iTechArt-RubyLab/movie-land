class CreateJoinTableCountriesMovies < ActiveRecord::Migration[6.1]
  def change
    create_join_table :countries, :movies do |t|
      # t.index [:country_id, :movie_id]
      # t.index [:movie_id, :country_id]
    end
  end
end
