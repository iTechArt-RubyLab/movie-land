class Award < ApplicationRecord
  validates :name, length: { in: 2..50 }
  validates :nomination, length: { in: 2..200 }
end
