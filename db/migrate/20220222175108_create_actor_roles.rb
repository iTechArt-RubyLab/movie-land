class CreateActorRoles < ActiveRecord::Migration[6.1]
  def change
    create_table :actor_roles do |t|
      t.string :role_name
      t.references :person, null: false, foreign_key: true
      t.references :movie, null: false, foreign_key: true

      t.timestamps
    end
  end
end
