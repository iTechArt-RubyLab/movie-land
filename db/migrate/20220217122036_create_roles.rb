class CreateRoles < ActiveRecord::Migration[6.1]
  def change
    create_table :roles do |t|
      t.string :name
      t.boolean :can_give_role
      t.boolean :can_create_role
      t.boolean :can_read_entities
      t.boolean :can_edit_entities
      t.boolean :can_leave_rating
      t.boolean :can_read_rating
      t.boolean :can_read_movies
      t.boolean :can_edit_movies
      t.boolean :can_create_movie_without_approve
      t.boolean :can_approve_movies
      t.boolean :can_approve_redactor

      t.timestamps
    end
  end
end
