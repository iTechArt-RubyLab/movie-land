class MoviesTag < ApplicationRecord
  belongs_to :movie
  belongs_to :tag
  # rubocop:disable Rails/UniqueValidationWithoutIndex
  validates :movie_id, uniqueness: { scope: :tag_id, message: 'This tag already appointed' }
  # rubocop:enable Rails/UniqueValidationWithoutIndex
end
