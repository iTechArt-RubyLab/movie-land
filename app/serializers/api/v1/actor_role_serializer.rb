module Api
  module V1
    class ActorRoleSerializer < ActiveModel::Serializer
      attributes :id, :role_name, :actor
      belongs_to :actor, serializer: PersonSerializer
    end
  end
end
