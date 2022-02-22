module Api
  module V1
    class AccessUserController < ApplicationController
      before_action :set_user, only: %i[update]

      def update
        case params[:status]
        when 'lock'
          @user.lock_access!
        when 'unlock'
          @user.unlock_access!
        end
      end

      private

      def set_user
        @user = User.find(params[:user_id])
      end

      def user_params
        params.require(:user).permit(:user_id, :status)
      end
    end
  end
end
