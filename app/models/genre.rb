class Genre < ApplicationRecord
  has_and_belongs_to_many :movies

  validates :name, length: { in: 2..50 }
end
