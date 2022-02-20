class Role < ApplicationRecord
  has_one :permission, dependent: :destroy

  accepts_nested_attributes_for :permission
end
