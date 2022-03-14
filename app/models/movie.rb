# == Schema Information
#
# Table name: movies
#
#  id                :bigint           not null, primary key
#  age_limit         :integer
#  budget            :bigint
#  description       :text
#  duration          :integer
#  images            :string           default([]), is an Array
#  name              :string
#  number_of_ratings :integer          default(0)
#  poster            :string
#  release_date      :date
#  tagline           :string
#  total_score       :integer          default(0)
#  trailer           :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
# Indexes
#
#  index_movies_on_name  (name) UNIQUE
#
class Movie < ApplicationRecord
  include Searchable

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
  has_many :actor_roles, dependent: :delete_all
  has_many :actors, through: :actor_roles, dependent: :destroy, class_name: 'Person'
  has_many :movie_staffs, dependent: :delete_all
  has_many :staffs, through: :movie_staffs, dependent: :destroy, class_name: 'Person'
  has_many :view_lists, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :delete_all
  has_many :movie_awards, dependent: :destroy
  accepts_nested_attributes_for :movies_tags

  mount_uploader :poster, PosterUploader
  mount_uploaders :images, ImageUploader

  validates :name, length: { in: 2..300 }, uniqueness: { message: 'This movie already exists' }
  validates :description, length: { in: 2..500 }
  validates :tagline, length: { in: 2..300 }
  validates :trailer, url: true
  validates :age_limit, numericality: { only_integer: true }, inclusion: { in: 1..100 }
  validates :budget, numericality: { only_integer: true, greater_than: 0 }
  validates :duration, numericality: { only_integer: true, greater_than: 1 }

  def average_rating
    number_of_ratings.zero? ? 0 : total_score / number_of_ratings
  end

  def directors
    staffs_by_occupation(:director)
  end

  def editors
    staffs_by_occupation(:editor)
  end

  def compositors
    staffs_by_occupation(:compositor)
  end

  def artists
    staffs_by_occupation(:artist)
  end

  def producers
    staffs_by_occupation(:producer)
  end

  def screencasters
    staffs_by_occupation(:screencaster)
  end

  private

  def staffs_by_occupation(occupation)
    staffs.where(movie_staffs: { staff_type: occupation })
  end
end
