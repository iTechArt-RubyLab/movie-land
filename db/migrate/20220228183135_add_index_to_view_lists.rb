class AddIndexToViewLists < ActiveRecord::Migration[6.1]
  disable_ddl_transaction!

  def change
    add_index :view_lists, [:watching_status, :movie_id], unique: true, algorithm: :concurrently
  end
end
