class Country < ApplicationRecord
  has_many :countries_movies
  has_many :movies, through: :countries_movies, dependent: :destroy

  validates :name, presence: true, length: { minimum: 3, maximum: 100 }
end
