# == Schema Information
#
# Table name: actor_roles
#
#  id         :bigint           not null, primary key
#  role_name  :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  movie_id   :bigint           not null
#  person_id  :bigint           not null
#
# Indexes
#
#  index_actor_roles_on_movie_id   (movie_id)
#  index_actor_roles_on_person_id  (person_id)
#
# Foreign Keys
#
#  fk_rails_...  (movie_id => movies.id)
#  fk_rails_...  (person_id => people.id)
#
class ActorRole < ApplicationRecord
  belongs_to :person
  belongs_to :movie
end
