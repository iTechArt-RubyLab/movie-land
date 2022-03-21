class AddBiographyToPeople < ActiveRecord::Migration[6.1]
  def change
    add_column :people, :biography, :text
  end
end
