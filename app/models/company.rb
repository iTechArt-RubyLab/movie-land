class Company < ApplicationRecord
  has_many :companies_movies, dependent: :delete_all
  has_many :movies, through: :companies_movies, dependent: :destroy

  validates :name, length: { in: 2..200 }, uniqueness: { message: 'This company already exists' }
end
