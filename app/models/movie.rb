# == Schema Information
#
# Table name: movies
#
#  id           :bigint           not null, primary key
#  age_limit    :integer
#  budget       :bigint
#  description  :text
#  duration     :integer
#  name         :string
#  release_date :date
#  tagline      :string
#  trailer      :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_movies_on_name  (name) UNIQUE
#
class Movie < ApplicationRecord
  has_many :companies_movies, dependent: :delete_all
  has_many :companies, through: :companies_movies, dependent: :destroy
  has_many :countries_movies, dependent: :delete_all
  has_many :countries, through: :countries_movies, dependent: :destroy
  has_many :genres_movies, dependent: :delete_all
  has_many :genres, through: :genres_movies, dependent: :destroy
  has_many :languages_movies, dependent: :delete_all
  has_many :languages, through: :languages_movies, dependent: :destroy
  has_many :movies_tags, dependent: :delete_all
  has_many :tags, through: :movies_tags, dependent: :destroy
  has_many :ratings, dependent: :destroy
  accepts_nested_attributes_for :movies_tags
  has_many :actor_roles, dependent: :delete_all
  has_many :actors, through: :actor_roles, dependent: :destroy, class_name: 'Person'
  has_many :movie_staffs, dependent: :delete_all
  has_many :people, through: :movie_staffs, dependent: :destroy

  validates :name, length: { in: 2..300 }, uniqueness: { message: 'This movie already exists' }
  validates :description, length: { in: 2..500 }
  validates :tagline, length: { in: 2..300 }
  validates :trailer, url: true
  validates :age_limit, numericality: { only_integer: true }, inclusion: { in: 1..100 }
  validates :budget, numericality: { only_integer: true, greater_than: 0 }
  validates :duration, numericality: { only_integer: true, greater_than: 1 }
end
