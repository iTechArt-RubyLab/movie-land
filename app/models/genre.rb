class Genre < ApplicationRecord
  validates :name, length: { in: 2..50 }
end
