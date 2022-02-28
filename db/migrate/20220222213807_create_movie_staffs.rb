class CreateMovieStaffs < ActiveRecord::Migration[6.1]
  def change
    create_table :movie_staffs do |t|
      t.integer :staff_type, null: false, default: 0
      t.references :movie, null: false, foreign_key: true
      t.references :staff, null: false, foreign_key: { to_table: :people }
      
      t.timestamps
    end
  end
end
