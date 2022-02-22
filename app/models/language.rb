# == Schema Information
#
# Table name: languages
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_languages_on_name  (name) UNIQUE
#
class Language < ApplicationRecord
  has_many :languages_movies, dependent: :delete_all
  has_many :movies, through: :languages_movies, dependent: :destroy

  validates :name, length: { minimum: 3, maximum: 40 }, uniqueness: { message: 'This language already exists' }
end
