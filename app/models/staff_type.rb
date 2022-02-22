class StaffType < ApplicationRecord
  validates :name, length: { minimum: 2, maximum: 30 }, uniqueness: { message: 'This staff type already exists' }
end
