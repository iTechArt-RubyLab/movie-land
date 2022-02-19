module Api
  module V1
    class MoviesController < ApplicationController
      before_action :set_movie, only: %i[show update destroy]

      def index
        @movies = Dictionary::FindService.new(Movie, params).call

        render json: @movies, each_serializer: MovieSerializer
      end

      def show
        render json: @movie, serializer: MovieSerializer
      end

      def create
        @movie = Movie.new(movie_params)

        if @movie.save
          render json: @movie, status: :created, serializer: MovieSerializer
        else
          render json: @movie.errors, status: :unprocessable_entity
        end
      end

      def update
        if @movie.update(movie_params)
          render json: @movie, serializer: MovieSerializer
        else
          render json: @movie.errors, status: :unprocessable_entity
        end
      end

      def destroy
        @movie.destroy
      end

      private

      def set_movie
        @movie = Movie.find(params[:id])
      end

      def movie_params
        params.require(:movie).permit(%i[name description tagline trailer release_date age_limit budget duration])
      end
    end
  end
end
