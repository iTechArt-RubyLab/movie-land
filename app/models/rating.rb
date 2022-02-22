class Rating < ApplicationRecord
  belongs_to :user
  belongs_to :movie

  validates :body, length: { in: 5..255 }
  validates :rating, numericality: { only_integer: true }, inclusion: { in: 1..5 }
end
