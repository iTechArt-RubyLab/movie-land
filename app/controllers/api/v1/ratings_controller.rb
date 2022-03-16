module Api
  module V1
    class RatingsController < ApplicationController
      before_action :set_rating, only: %i[update destroy]
      before_action :authenticate_user!
      before_action :authorize_rating!
      after_action :verify_authorized

      def index
        @ratings = Ratings::FindService.call(current_user, params)

        render json: @ratings, each_serializer: RatingSerializer
      end

      def create
        @rating = current_user.ratings.new(rating_params)

        if @rating.save
          render json: @rating, status: :created, serializer: RatingSerializer
        else
          render json: @rating.errors, status: :unprocessable_entity
        end
      end

      def update
        if @rating.update(rating_params)
          render json: @rating, serializer: RatingSerializer
        else
          render json: @rating.errors, status: :unprocessable_entity
        end
      end

      def destroy
        @rating.destroy
      end

      private

      def set_rating
        @rating = Rating.find(params[:id])
      end

      def rating_params
        params.require(:rating).permit(%i[rating user_id movie_id])
      end

      def authorize_rating!
        authorize(@rating || Rating)
      end
    end
  end
end
