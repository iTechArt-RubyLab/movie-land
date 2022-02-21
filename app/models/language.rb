class Language < ApplicationRecord
  has_many :languages_movies, dependent: :delete_all
  has_many :movies, through: :languages_movies, dependent: :destroy

  validates :name, length: { minimum: 3, maximum: 40 }
end
