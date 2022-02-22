class CompaniesMovie < ApplicationRecord
  belongs_to :movie
  belongs_to :company
  validates :movie_id, uniqueness: { scope: :company_id, message: 'This company already appointed' }
end
