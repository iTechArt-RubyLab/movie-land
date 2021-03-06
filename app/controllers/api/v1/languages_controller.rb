module Api
  module V1
    class LanguagesController < ApplicationController
      before_action :set_language, only: %i[update destroy]
      before_action :authorize_language!
      after_action :verify_authorized

      def index
        @languages = Dictionary::FindService.call(Language, params)

        render json: @languages, each_serializer: DictionarySerializer
      end

      def create
        @language = Language.new(language_params)

        if @language.save
          render json: @language, status: :created, serializer: DictionarySerializer
        else
          render json: @language.errors, status: :unprocessable_entity
        end
      end

      def update
        if @language.update(language_params)
          render json: @language, serializer: DictionarySerializer
        else
          render json: @language.errors, status: :unprocessable_entity
        end
      end

      def destroy
        @language.destroy
      end

      private

      def set_language
        @language = Language.find(params[:id])
      end

      def language_params
        params.require(:language).permit(%i[name])
      end

      def authorize_language!
        authorize(@language || Language)
      end
    end
  end
end
