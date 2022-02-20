class Role < ApplicationRecord
  has_one :permission, dependent: :destroy
  has_many :users, dependent: :nullify
  validates :name, uniqueness: { scope: :name, message: 'This role already exists' }

  accepts_nested_attributes_for :permission
end
