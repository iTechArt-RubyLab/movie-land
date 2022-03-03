class AddWatchingStatusToViewLists < ActiveRecord::Migration[6.1]
  def change
    add_column :view_lists, :watching_status, :string
  end
end
