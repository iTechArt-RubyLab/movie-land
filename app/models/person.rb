# == Schema Information
#
# Table name: people
#
#  id         :bigint           not null, primary key
#  biography  :text
#  birthday   :date
#  deathday   :date
#  married    :boolean
#  name       :string
#  surname    :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  country_id :bigint
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
  include Searchable

  belongs_to :country, optional: true
  has_many :actor_roles, foreign_key: :actor_id, class_name: 'ActorRole', dependent: :delete_all, inverse_of: :actor
  has_many :movies, through: :actor_roles, dependent: :destroy
  has_many :movie_staffs, foreign_key: :staff_id, class_name: 'MovieStaff', dependent: :delete_all, inverse_of: :staff
  has_many :movies, through: :movie_staffs, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :delete_all
  has_many :movie_awards_person, dependent: :delete_all
  has_many :movie_awards, through: :movie_awards_person, dependent: :destroy

  validates :name, length: { in: 2..103 }
  validates :surname, length: { in: 2..103 }

  settings index: { number_of_shards: 1 } do
    mappings dynamic: 'false' do
      indexes :name, type: 'text', analyzer: 'ngram_analyzer',
                     search_analyzer: 'whitespace_analyzer'
      indexes :surname, type: 'text', analyzer: 'ngram_analyzer',
                        search_analyzer: 'whitespace_analyzer'
    end
  end
end
