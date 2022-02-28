module Api
  module V1
    class ViewListsController < ApplicationController
      before_action :authenticate_user!
      before_action :set_view_list, only: %i[update destroy]

      def index
        @view_lists = ViewListService.new(ViewList, params, current_user).call

        render json: @view_lists, each_serializer: ViewListSerializer
      end

      def create
        @view_list = current_user.view_lists.new(view_list_params)

        if @view_list.save
          render json: @view_list, status: :created, serializer: ViewListSerializer
        else
          render json: @view_list.errors, status: :unprocessable_entity
        end
      end

      def update
        if @view_list.update(view_list_params)
          render json: @view_list, serializer: ViewListSerializer
        else
          render json: @view_list.errors, status: :unprocessable_entity
        end
      end

      def destroy
        @view_list.destroy
      end

      private

      def set_view_list
        @view_list = ViewList.find(params[:id])
      end

      def view_list_params
        params.require(:view_list).permit(:watching_status, :user_id, :movie_id)
      end
    end
  end
end