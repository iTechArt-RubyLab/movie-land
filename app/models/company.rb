# == Schema Information
#
# Table name: companies
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_companies_on_name  (name) UNIQUE
#
class Company < ApplicationRecord
  has_many :companies_movies, dependent: :delete_all
  has_many :movies, through: :companies_movies, dependent: :destroy

  validates :name, length: { in: 2..200 }, uniqueness: { message: 'This company already exists' }
end
