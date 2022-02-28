class AddIndexToStaffType < ActiveRecord::Migration[6.1]
  disable_ddl_transaction!

  def change
    add_index :staff_types, :name, unique: true, algorithm: :concurrently
  end
end
