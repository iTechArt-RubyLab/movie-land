class Movie < ApplicationRecord
  belongs_to :poster, class_name: 'Image'
  belongs_to :image
  belongs_to :category
end
