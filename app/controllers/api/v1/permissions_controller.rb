module Api
  module V1
    class PermissionsController < ApplicationController
      before_action :set_permission, only: %i[show update destroy]

      def index
        @permissions = Permission.all

        render json: @permissions, each_serializer: PermissionSerializer
      end

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
        @permission = Permission.find(params[:id])
      end

      def permission_params
        params.require(:permission).permit(:can_lock_user, :can_edit_role, :can_set_role, :can_read, :can_edit)
      end
    end
  end
end
