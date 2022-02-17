class Country < ApplicationRecord
  validates :title, presence: true, length: { minimum: 3, maximum: 100 }
end
