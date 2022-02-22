class AddIndexToTables < ActiveRecord::Migration[6.1]
  disable_ddl_transaction!

  def change
    add_index :companies, :name, unique: true, algorithm: :concurrently
    add_index :countries, :name, unique: true, algorithm: :concurrently
    add_index :genres, :name, unique: true, algorithm: :concurrently
    add_index :languages, :name, unique: true, algorithm: :concurrently
    add_index :movies, :name, unique: true, algorithm: :concurrently
  end
end
