class Company < ApplicationRecord
  validates :title, length: { in: 2..200 }
end
