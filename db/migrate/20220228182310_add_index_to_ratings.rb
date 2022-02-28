class AddIndexToRatings < ActiveRecord::Migration[6.1]
  disable_ddl_transaction!

  def change
    add_index :ratings, [:rating, :movie_id], unique: true, algorithm: :concurrently
  end
end
