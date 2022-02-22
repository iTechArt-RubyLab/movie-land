class CreateMovieStaffs < ActiveRecord::Migration[6.1]
  def change
    create_table :movie_staffs do |t|
      t.references :movie, null: false, foreign_key: true
      t.references :person, null: false, foreign_key: true
      t.references :staff_type, null: false, foreign_key: true

      t.timestamps
    end
  end
end
