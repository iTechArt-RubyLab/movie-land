class CreatePermissions < ActiveRecord::Migration[6.1]
  def change
    create_table :permissions do |t|
      t.boolean :can_lock_user
      t.boolean :can_edit_role
      t.boolean :can_set_role
      t.boolean :can_read
      t.boolean :can_edit
      t.references :role, null: false, foreign_key: true

      t.timestamps
    end
  end
end
