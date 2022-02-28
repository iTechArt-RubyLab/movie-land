class AddIndexToStaffType < ActiveRecord::Migration[6.1]
  disable_ddl_transaction!

   def change
     add_index :movie_staffs, :staff_type, unique: true, algorithm: :concurrently
   end
end
