# == Schema Information
#
# Table name: movie_awards
#
#  id            :bigint           not null, primary key
#  delivery_year :integer
#  name          :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  award_id      :bigint           not null
#  movie_id      :bigint           not null
#
# Indexes
#
#  index_movie_awards_on_award_id  (award_id)
#  index_movie_awards_on_movie_id  (movie_id)
#
# Foreign Keys
#
#  fk_rails_...  (award_id => awards.id)
#  fk_rails_...  (movie_id => movies.id)
#
class MovieAward < ApplicationRecord
  belongs_to :movie
  belongs_to :award

  validates :name, length: { in: 2..200 }
  validates :delivery_year, numericality: { only_integer: true }, inclusion: { in: 1900..Time.zone.now.year }
end
