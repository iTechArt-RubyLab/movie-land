class Language < ApplicationRecord
  validates :name, length: { minimum: 3, maximum: 40 }
end