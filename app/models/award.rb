# == Schema Information
#
# Table name: awards
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  country_id :bigint           not null
#
# Indexes
#
#  index_awards_on_country_id  (country_id)
#  index_awards_on_name        (name) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (country_id => countries.id)
#
class Award < ApplicationRecord
  belongs_to :country

  validates :name, length: { in: 2..100 }, uniqueness: { message: 'This award already exists' }
end
