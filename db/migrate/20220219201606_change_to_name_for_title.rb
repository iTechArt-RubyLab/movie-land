class ChangeToNameForTitle < ActiveRecord::Migration[6.1]
  def change
    rename_column :companies, :title, :name
    rename_column :countries, :title, :name
    rename_column :movies, :title, :name
  end
end
