module Api
  module V1
    class PermissionSerializer < ActiveModel::Serializer
      attributes :can_lock_user, :can_edit_role, :can_set_role, :can_edit_movie_and_person, :can_read_movie_and_person, :can_read_entities, :can_edit_entities
    end
  end
end
