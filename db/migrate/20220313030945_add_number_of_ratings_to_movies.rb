class AddNumberOfRatingsToMovies < ActiveRecord::Migration[6.1]
  def change
    add_column :movies, :number_of_ratings, :integer, default: 0
  end
end
