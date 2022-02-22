# == Schema Information
#
# Table name: genres
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_genres_on_name  (name) UNIQUE
#
class Genre < ApplicationRecord
  has_many :genres_movies, dependent: :delete_all
  has_many :movies, through: :genres_movies, dependent: :destroy

  validates :name, length: { in: 2..50 }, uniqueness: { message: 'This genre already exists' }
end
