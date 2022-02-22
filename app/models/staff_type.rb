# == Schema Information
#
# Table name: staff_types
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_staff_types_on_name  (name) UNIQUE
#
class StaffType < ApplicationRecord
  validates :name, length: { minimum: 2, maximum: 30 }, uniqueness: { message: 'This staff type already exists' }
end
