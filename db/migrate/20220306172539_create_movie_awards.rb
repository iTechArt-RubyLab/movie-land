class CreateMovieAwards < ActiveRecord::Migration[6.1]
  def change
    create_table :movie_awards do |t|
      t.integer :delivery_year
      t.integer :nomination_type
      t.references :movie, null: false, foreign_key: true
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
