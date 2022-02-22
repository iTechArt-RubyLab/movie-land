class AddIndexToRole < ActiveRecord::Migration[6.1]
  disable_ddl_transaction!

  def change
    add_index :roles, :name, unique: true, algorithm: :concurrently
  end
end
