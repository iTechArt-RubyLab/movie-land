class Rating < ApplicationRecord
  belongs_to :user
  belongs_to :movie

  validates :body, presense: true, length: { in: 5..255 }
  validates :rating, presense: true, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }
end
