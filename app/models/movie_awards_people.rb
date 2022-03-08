# == Schema Information
#
# Table name: movie_awards_people
#
#  movie_award_id :bigint           not null
#  person_id      :bigint           not null
#
# Indexes
#
#  index_movie_awards_people_on_movie_award_id_and_person_id  (movie_award_id,person_id) UNIQUE
#  index_movie_awards_people_on_person_id_and_movie_award_id  (person_id,movie_award_id) UNIQUE
#
class MovieAwardsPeople < ApplicationRecord
  belongs_to :movie_award
  belongs_to :person
  validates :person_id, uniqueness: { scope: :movie_awards_id, message: 'This movie award already appointed' }
end
