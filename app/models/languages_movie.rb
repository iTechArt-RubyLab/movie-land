class LanguagesMovie < ApplicationRecord
  belongs_to :movie
  belongs_to :language
  validates :movie_id, uniqueness: { scope: :language_id, message: 'This language already appointed' }
end
