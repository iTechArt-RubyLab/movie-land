class AddIndexToUsers < ActiveRecord::Migration[6.1]
  disable_ddl_transaction!

  def change
    add_index :users, :username, unique: true, algorithm: :concurrently
  end
end
