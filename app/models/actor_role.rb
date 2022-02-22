class ActorRole < ApplicationRecord
  belongs_to :person
  belongs_to :movie
end
