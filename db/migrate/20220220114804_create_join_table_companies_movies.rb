class CreateJoinTableCompaniesMovies < ActiveRecord::Migration[6.1]
  def change
    create_join_table :companies, :movies do |t|
      t.index [:company_id, :movie_id]
      t.index [:movie_id, :company_id]
    end
  end
end
