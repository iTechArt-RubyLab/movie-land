# == Schema Information
#
# Table name: countries
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_countries_on_name  (name) UNIQUE
#
class Country < ApplicationRecord
  has_many :countries_movies, dependent: :delete_all
  has_many :movies, through: :countries_movies, dependent: :destroy
  has_many :people, dependent: :nullify

  validates :name, length: { minimum: 2, maximum: 100 }, uniqueness: { message: 'This country already exists' }
end
