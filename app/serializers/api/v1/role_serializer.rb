module Api
  module V1
    class RoleSerializer < ActiveModel::Serializer
      attributes :id, :name
      has_one :permission
    end
  end
end
