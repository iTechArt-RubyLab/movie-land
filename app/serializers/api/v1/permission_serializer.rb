module Api
  module V1
    class PermissionSerializer < ActiveModel::Serializer
      attributes :can_lock_user, :can_edit_role, :can_set_role, :can_read, :can_edit
    end
  end
end
