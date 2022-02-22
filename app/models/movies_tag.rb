class MoviesTag < ApplicationRecord
  belongs_to :movie
  belongs_to :tag
  validates :movie_id, uniqueness: { scope: :tag_id, message: 'This tag already appointed' }
end
