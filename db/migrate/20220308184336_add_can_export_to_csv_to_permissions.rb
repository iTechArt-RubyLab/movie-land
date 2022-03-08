class AddCanExportToCsvToPermissions < ActiveRecord::Migration[6.1]
  def change
    add_column :permissions, :can_export_to_csv, :boolean
  end
end
