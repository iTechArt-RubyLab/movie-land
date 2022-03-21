class AddIndexToMovieStaffs < ActiveRecord::Migration[6.1]
  disable_ddl_transaction!
  
  def change
    add_index  :movie_staffs, [:staff_type, :movie_id, :staff_id], unique: true, algorithm: :concurrently
  end  
end
