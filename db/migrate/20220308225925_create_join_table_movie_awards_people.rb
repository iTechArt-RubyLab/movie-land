class CreateJoinTableMovieAwardsPeople < ActiveRecord::Migration[6.1]
  def change
    create_join_table :people, :movie_awards do |t|
      t.index [:person_id, :movie_award_id], unique: true
      t.index [:movie_award_id, :person_id], unique: true
    end
  end
end
