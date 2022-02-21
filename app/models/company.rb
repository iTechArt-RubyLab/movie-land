class Company < ApplicationRecord
  # rubocop:disable Rails/HasManyOrHasOneDependent
  has_many :companies_movies
  # rubocop:enable Rails/HasManyOrHasOneDependent
  has_many :movies, through: :companies_movies, dependent: :destroy

  validates :name, length: { in: 2..200 }
end
