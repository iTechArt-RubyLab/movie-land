# == Schema Information
#
# Table name: movie_awards
#
#  id              :bigint           not null, primary key
#  delivery_year   :integer
#  nomination_type :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  category_id     :bigint           not null
#  movie_id        :bigint           not null
#
# Indexes
#
#  index_movie_awards_on_category_id  (category_id)
#  index_movie_awards_on_movie_id     (movie_id)
#
# Foreign Keys
#
#  fk_rails_...  (category_id => categories.id)
#  fk_rails_...  (movie_id => movies.id)
#
class MovieAward < ApplicationRecord
  belongs_to :movie
  belongs_to :category
  has_many :movie_awards_person, dependent: :delete_all
  has_many :people, through: :movie_awards_person, dependent: :destroy

  enum nomination_type: { winner: 0, nominator: 1 }

  validates :delivery_year, numericality: { only_integer: true }, inclusion: { in: 1900..Time.zone.now.year }
end
