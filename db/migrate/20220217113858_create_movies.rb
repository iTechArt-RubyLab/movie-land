class CreateMovies < ActiveRecord::Migration[6.1]
  def change
    create_table :movies do |t|
      t.string :title
      t.text :description
      t.string :tagline
      t.string :trailer
      t.date :release_date
      t.references :poster, null: false, foreign_key: true
      t.references :image, null: false, foreign_key: true
      t.integer :age_limit
      t.bigint :budget
      t.references :category, null: false, foreign_key: true
      t.integer :duration
      t.references :season, null: false, foreign_key: true

      t.timestamps
    end
  end
end
