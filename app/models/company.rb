class Company < ApplicationRecord
  has_and_belongs_to_many :movies
  validates :name, length: { in: 2..200 }
end
