class AddIndexToTag < ActiveRecord::Migration[6.1]
  disable_ddl_transaction!

  def change
    add_index :tags, :name, unique: true, algorithm: :concurrently
  end
end
