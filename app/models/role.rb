class Role < ApplicationRecord
  has_one :permission, dependent: :destroy
  validates :name, uniqueness: { scope: :name, message: 'This role already exists' }

  accepts_nested_attributes_for :permission
end
