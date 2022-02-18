class CreateMovies < ActiveRecord::Migration[6.1]
  def change
    create_table :movies do |t|
      t.string :title
      t.text :description
      t.string :tagline
      t.string :trailer
      t.date :release_date
      t.integer :age_limit
      t.bigint :budget
      t.integer :duration

      t.timestamps
    end
  end
end
