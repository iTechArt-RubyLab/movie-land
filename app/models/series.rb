class Series < ApplicationRecord
  belongs_to :poster, class_name: 'Image'

  validates :title, length: { in: 2..300 }
  validates :description, length: { in: 2..500 }
  validates :trailer, url: true
end
