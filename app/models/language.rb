class Language < ApplicationRecord
  # rubocop:disable Rails/HasManyOrHasOneDependent
  has_many :languages_movies
  # rubocop:enable Rails/HasManyOrHasOneDependent
  has_many :movies, through: :languages_movies, dependent: :destroy

  validates :name, length: { minimum: 3, maximum: 40 }
end
