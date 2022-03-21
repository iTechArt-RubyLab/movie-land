# == Schema Information
#
# Table name: companies_movies
#
#  company_id :bigint           not null
#  movie_id   :bigint           not null
#
# Indexes
#
#  index_companies_movies_on_company_id_and_movie_id  (company_id,movie_id) UNIQUE
#  index_companies_movies_on_movie_id_and_company_id  (movie_id,company_id) UNIQUE
#
class CompaniesMovie < ApplicationRecord
  belongs_to :movie
  belongs_to :company

  validates :movie_id, uniqueness: { scope: :company_id, message: 'This company already appointed' }
end
