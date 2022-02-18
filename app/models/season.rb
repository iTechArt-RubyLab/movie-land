class Season < ApplicationRecord
  belongs_to :poster, class_name: 'Image'
  belongs_to :series

  validates :title, length: { in: 2..300 }
  validates :number, numericality: { only_integer: true }, inclusion: { in: 1..100 }
  validates :description, length: { in: 2..500 }
  validates :trailer, url: true
end
