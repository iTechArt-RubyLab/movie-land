class Country < ApplicationRecord
  validates :name, presence: true, length: { minimum: 3, maximum: 100 }
end
