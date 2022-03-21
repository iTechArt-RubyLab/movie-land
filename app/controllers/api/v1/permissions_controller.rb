module Api
  module V1
    class PermissionsController < ApplicationController
      before_action :set_permission, only: %i[show update]
      before_action :authorize_permission!
      after_action :verify_authorized

      def show
        render json: @permission, serializer: PermissionSerializer
      end

      def create
        @permission = Role.find(params[:role_id]).build_permission(permission_params)

        if @permission.save
          render json: @permission, status: :created, serializer: PermissionSerializer
        else
          render json: @permission.errors, status: :unprocessable_entity
        end
      end

      def update
        if @permission.update(permission_params)
          render json: @permission, serializer: PermissionSerializer
        else
          render json: @permission.errors, status: :unprocessable_entity
        end
      end

      private

      def set_permission
        @permission = Permission.find_by(role_id: params[:role_id])
      end

      def permission_params
        params.require(:permission).permit(:can_lock_user, :can_edit_role, :can_edit_permission,
                                           :can_read_rating, :can_give_rating, :can_set_role,
                                           :can_edit_movie, :can_read_movie, :can_edit_person,
                                           :can_read_person, :can_read_entities, :can_edit_entities,
                                           :can_read_user, :can_edit_view_list, :can_read_view_list,
                                           :can_leave_comment, :can_export_to_csv, :can_use_search)
      end

      def authorize_permission!
        authorize(@permission || Permission)
      end
    end
  end
end
