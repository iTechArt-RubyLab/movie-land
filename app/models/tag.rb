class Tag < ApplicationRecord
  has_many :movies_tags, dependent: :delete_all
  has_many :movies, through: :movies_tags, dependent: :destroy
  validates :name, length: { minimum: 2, maximum: 30 }, uniqueness: { message: 'This tag already exists' }
end
