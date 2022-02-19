class Company < ApplicationRecord
  validates :name, length: { in: 2..200 }
end
