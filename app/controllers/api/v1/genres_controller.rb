module Api
  module V1
    class GenresController < ApplicationController
      before_action :set_genre, only: %i[show update destroy]

      def index
        @genres = Dictionary::FindService.new(Genre, params).call

        render json: @genres, each_serializer: DictionarySerializer
      end

      def show
        render json: @genre, serializer: DictionarySerializer
      end

      def create
        @genre = Genre.new(genre_params)

        if @genre.save
          render json: @genre, status: :created, serializer: DictionarySerializer
        else
          render json: @genre.errors, status: :unprocessable_entity
        end
      end

      def update
        if @genre.update(genre_params)
          render json: @genre, serializer: DictionarySerializer
        else
          render json: @genre.errors, status: :unprocessable_entity
        end
      end

      def destroy
        @genre.destroy
      end

      private

      def set_genre
        @genre = Genre.find(params[:id])
      end

      def genre_params
        params.require(:genre).permit(%i[name])
      end
    end
  end
end