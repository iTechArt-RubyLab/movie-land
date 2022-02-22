module Api
  module V1
    class UserController < ApplicationController
      before_action :set_user, only: %i[show update]

      def index
        @users = User.all

        render json: @users
      end

      def show
        render json: @user
      end

      def update
        if @user.update(user_params)
          render json: @user
        else
          render json: @user.errors, status: :unprocessable_entity
        end
      end

      private

      def set_user
        @user = User.find(params[:id])
      end

      def user_params
        params.require(:user).permit(:id, :role_id)
      end
    end
  end
end
