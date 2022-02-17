class Movie < ApplicationRecord
  belongs_to :poster
  belongs_to :image
  belongs_to :category
  belongs_to :season
end
