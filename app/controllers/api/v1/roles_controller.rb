module Api
  module V1
    class RolesController < ApplicationController
      before_action :set_role, only: %i[update destroy]

      def index
        @roles = Dictionary::FindService.new(Role, params).call

        render json: @roles, each_serializer: RoleSerializer
      end

      def create
        @role = Role.new(role_params)

        if @role.save
          render json: @role, status: :created, serializer: RoleSerializer
        else
          render json: @role.errors, status: :unprocessable_entity
        end
      end

      def update
        if @role.update(role_params)
          render json: @role, serializer: RoleSerializer
        else
          render json: @role.errors, status: :unprocessable_entity
        end
      end

      def destroy
        @role.destroy
      end

      private

      def set_role
        @role = Role.find(params[:id])
      end

      def role_params
        params.require(:role).permit(:name, permission_attributes: %i[can_lock_user can_edit_role can_edit_permission can_read_rating can_give_rating
                                                                      can_set_role can_edit_movie can_read_movie can_edit_person can_read_person
                                                                      can_read_entities can_edit_entities can_read_user])
      end
    end
  end
end
