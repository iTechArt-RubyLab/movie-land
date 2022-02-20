class Country < ApplicationRecord
  # rubocop:disable Rails/HasManyOrHasOneDependent
  has_many :countries_movies
  # rubocop:enable Rails/HasManyOrHasOneDependent
  has_many :movies, through: :countries_movies, dependent: :destroy

  has_many :people
  validates :name, presence: true, length: { minimum: 3, maximum: 100 }
end
