class Country < ApplicationRecord
  has_many :countries_movies, dependent: :delete_all
  has_many :movies, through: :countries_movies, dependent: :destroy
  has_many :people, dependent: :nullify

  validates :name, length: { minimum: 3, maximum: 100 }, uniqueness: { message: 'This country already exists' }
end
