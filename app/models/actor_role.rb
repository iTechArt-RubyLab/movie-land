# == Schema Information
#
# Table name: actor_roles
#
#  id         :bigint           not null, primary key
#  role_name  :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  actor_id   :bigint           not null
#  movie_id   :bigint           not null
#
# Indexes
#
#  index_actor_roles_on_actor_id                             (actor_id)
#  index_actor_roles_on_movie_id                             (movie_id)
#  index_actor_roles_on_role_name_and_movie_id_and_actor_id  (role_name,movie_id,actor_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (actor_id => people.id)
#  fk_rails_...  (movie_id => movies.id)
#
class ActorRole < ApplicationRecord
  include Searchable

  belongs_to :actor, class_name: 'Person'
  belongs_to :movie
  validates :role_name, uniqueness: { scope: %i[movie_id actor_id], message: 'This actor role already appointed' }

  settings index: { number_of_shards: 1 } do
    mappings dynamic: 'false' do
      indexes :role_name
    end
  end
end
