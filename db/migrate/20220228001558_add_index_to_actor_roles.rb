class AddIndexToActorRoles < ActiveRecord::Migration[6.1]
  disable_ddl_transaction!
    
 def change
    add_index  :actor_roles, [:role_name, :movie_id, :actor_id], unique: true, algorithm: :concurrently
  end  
end
