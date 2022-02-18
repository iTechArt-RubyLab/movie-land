class Person < ApplicationRecord
  belongs_to :country
  validates :name, length: { in: 2..103 }
  validates :surname, length: { in: 2..103 }
end
