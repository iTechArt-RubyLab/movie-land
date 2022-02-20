class CompaniesMovie < ApplicationRecord
  belongs_to :movie
  belongs_to :company
  # rubocop:disable Rails/UniqueValidationWithoutIndex
  validates :movie_id, uniqueness: { scope: :company_id, message: 'This company already appointed' }
  # rubocop:enable Rails/UniqueValidationWithoutIndex
end
