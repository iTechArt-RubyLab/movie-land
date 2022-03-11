module Api
  module V1
    class MovieReportsController < ApplicationController
      before_action :authorize_movie_report!
      after_action :verify_authorized

      def index
        @movies = Movie.all

        respond_to do |format|
          format.csv do
            send_data Export::CsvGeneratorService.new(@movies, MOVIE_COLUMNS, Movie).to_csv,
                      filename: 'movies.csv'
          end
        end
      end

      def show
        @movie = Movie.find(params[:movie_id])

        respond_to do |format|
          format.csv do
            send_data Export::CsvGeneratorService.new(@movie, MOVIE_COLUMNS, Movie).to_csv,
                      filename: "#{params[:movie_id]}_movie.csv"
          end
        end
      end

      private

      MOVIE_COLUMNS = %w[id name tagline description release_date duration age_limit budget trailer].freeze

      def authorize_movie_report!
        authorize(@movie || Movie)
      end
    end
  end
end
