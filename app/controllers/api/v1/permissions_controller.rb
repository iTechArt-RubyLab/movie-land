module Api
  module V1
    class PermissionsController < ApplicationController
      before_action :set_permission, only: %i[show update destroy]

      def show
        render json: @permission, serializer: PermissionSerializer
      end

      def create
        @permission = Permission.new(permission_params)

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

      def destroy
        @permission.destroy
      end

      private

      def set_permission
        @permission = Permission.find(params[:role_id])
      end

      def permission_params
        params.require(:permission).permit(:can_lock_user, :can_edit_role, :can_edit_permission,
                                           :can_set_role, :can_edit_movie_and_person, :can_read_movie_and_person,
                                           :can_read_entities, :can_edit_entities, :can_read_user)
      end
    end
  end
end
