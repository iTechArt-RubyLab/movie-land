module Api
  module V1
    class MoviesController < ApplicationController
      before_action :set_movie, only: %i[show update destroy]
      before_action :authorize_movie!
      after_action :verify_authorized

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
        params.require(:movie).permit(:name, :description, :tagline, :trailer, :release_date, :age_limit, :budget,
                                      :duration, { movies_tags_attributes: [tag_attributes: [:name]] })
      end

      def authorize_movie!
        authorize(@movie || Movie)
      end
    end
  end
end
