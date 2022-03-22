module Api
  module V1
    class MoviesController < ApplicationController
      before_action :set_movie, only: %i[show update destroy]
      before_action :authorize_movie!
      after_action :verify_authorized

      def index
        @movies = Movies::FindService.call(params)

        render json: @movies, each_serializer: MovieSerializer
      end

      def show
        render json: @movie, serializer: MovieSerializer
      end

      def create
        Movie.transaction do
          @movie = Movie.create!(movie_params)
          genres_ids = params[:movie][:genres_ids]
          genres_ids&.each do |genre_id|
            genre = Genre.find(genre_id)
            GenresMovie.create!(movie: @movie, genre: genre)
          end
          countries_ids = params[:movie][:countries_ids]
          countries_ids&.each do |country_id|
            country = Country.find(country_id)
            CountriesMovie.create!(movie: @movie, country: country)
          end
          companies_ids = params[:movie][:companies_ids]
          companies_ids&.each do |company_id|
            company = Company.find(company_id)
            CompaniesMovie.create!(movie: @movie, company: company)
          end
          languages_ids = params[:movie][:languages_ids]
          languages_ids&.each do |language_id|
            language = Language.find(language_id)
            LanguagesMovie.create!(movie: @movie, language: language)
          end
        end

        if @movie.present?
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
        params
          .require(:movie)
          .permit(:name, :description, :tagline, :trailer, :release_date,
                  :age_limit, :budget, :duration, :poster, { images: [] },
                  :remote_poster_url, { remote_images_url: [] },
                  { movies_tags_attributes: [tag_attributes: [:name]] })
      end

      def authorize_movie!
        authorize(@movie || Movie)
      end
    end
  end
end
