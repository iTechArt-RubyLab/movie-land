class Language < ApplicationRecord
  has_and_belongs_to_many :movies

  validates :name, length: { minimum: 3, maximum: 40 }
end
