class Tag < ApplicationRecord
  validates :name, length: { minimum: 2, maximum: 30 }
end
