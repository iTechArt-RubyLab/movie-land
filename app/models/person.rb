# == Schema Information
#
# Table name: people
#
#  id         :bigint           not null, primary key
#  birthday   :date
#  deathday   :date
#  married    :boolean
#  name       :string
#  surname    :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  country_id :bigint           not null
#
# Indexes
#
#  index_people_on_country_id  (country_id)
#
# Foreign Keys
#
#  fk_rails_...  (country_id => countries.id)
#
class Person < ApplicationRecord
  belongs_to :country
  has_many :actor_roles, dependent: :delete_all
  has_many :movies, through: :actor_roles, dependent: :destroy
  validates :name, length: { in: 2..103 }
  validates :surname, length: { in: 2..103 }
end
