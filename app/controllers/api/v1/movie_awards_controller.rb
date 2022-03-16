module Api
  module V1
    class MovieAwardsController < ApplicationController
      before_action :set_movie_award, only: %i[show update destroy]
      before_action :authorize_movie_award!
      after_action :verify_authorized

      def index
        @movie_awards = MovieAwards::FindService.call(params)

        render json: @movie_awards, each_serializer: MovieAwardSerializer
      end

      def show
        render json: @movie_award, serializer: MovieAwardSerializer
      end

      def create
        @movie_award = Movie.find(params[:movie_id]).movie_awards.build(movie_award_params)

        if @movie_award.save
          render json: @movie_award, status: :created, serializer: MovieAwardSerializer
        else
          render json: @movie_award.errors, status: :unprocessable_entity
        end
      end

      def update
        if @movie_award.update(movie_award_params)
          render json: @movie_award, serializer: MovieAwardSerializer
        else
          render json: @movie_award.errors, status: :unprocessable_entity
        end
      end

      def destroy
        @movie_award.destroy
      end

      private

      def set_movie_award
        @movie_award = Movie.find(params[:movie_id]).movie_awards.find(params[:id])
      end

      def movie_award_params
        params.require(:movie_award).permit(:category_id, :delivery_year, :nomination_type)
      end

      def authorize_movie_award!
        authorize(@movie_award || MovieAward)
      end
    end
  end
end
