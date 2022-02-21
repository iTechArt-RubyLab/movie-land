class CountriesMovie < ApplicationRecord
  belongs_to :movie
  belongs_to :country
  # rubocop:disable Rails/UniqueValidationWithoutIndex
  validates :movie_id, uniqueness: { scope: :country_id, message: 'This country already appointed' }
  # rubocop:enable Rails/UniqueValidationWithoutIndex
end
