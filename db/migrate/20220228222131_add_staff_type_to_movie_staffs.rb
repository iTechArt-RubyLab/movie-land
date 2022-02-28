class AddStaffTypeToMovieStaffs < ActiveRecord::Migration[6.1]
  def change
    add_column :movie_staffs, :staff_type, :integer, default: 0
  end
end
