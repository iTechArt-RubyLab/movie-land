class Tag < ApplicationRecord
  # rubocop:disable Rails/HasManyOrHasOneDependent
  has_many :movies_tags
  has_many :movies, through: :movies_tags, dependent: :destroy
  # rubocop:enable Rails/HasManyOrHasOneDependent
  validates :name, length: { minimum: 2, maximum: 30 }
end
