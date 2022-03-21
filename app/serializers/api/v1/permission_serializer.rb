module Api
  module V1
    class PermissionSerializer < ActiveModel::Serializer
      attributes :can_lock_user, :can_edit_role, :can_set_role, :can_edit_movie, :can_read_rating,
                 :can_read_movie, :can_edit_person, :can_read_person, :can_give_rating,
                 :can_read_entities, :can_edit_entities, :can_edit_permission, :can_read_user,
                 :can_read_award, :can_edit_award, :can_read_view_list, :can_edit_view_list,
                 :can_leave_comment, :can_export_to_csv, :can_use_search
      belongs_to :role, serializer: RoleSerializer
    end
  end
end
