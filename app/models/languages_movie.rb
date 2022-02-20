class LanguagesMovie < ApplicationRecord
  belongs_to :movie
  belongs_to :language
  # rubocop:disable Rails/UniqueValidationWithoutIndex
  validates :movie_id, uniqueness: { scope: :language_id, message: 'This language already appointed' }
  # rubocop:enable Rails/UniqueValidationWithoutIndex
end
