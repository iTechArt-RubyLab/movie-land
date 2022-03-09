module Api
  module V1
    class CountriesController < ApplicationController
      before_action :set_country, only: %i[update destroy]
      before_action :authorize_country!
      after_action :verify_authorized

      def index
        @countries = Dictionary::FindService.call(Country, params)

        render json: @countries, each_serializer: DictionarySerializer
      end

      def create
        @country = Country.new(country_params)

        if @country.save
          render json: @country, status: :created, serializer: DictionarySerializer
        else
          render json: @country.errors, status: :unprocessable_entity
        end
      end

      def update
        if @country.update(country_params)
          render json: @country, serializer: DictionarySerializer
        else
          render json: @country.errors, status: :unprocessable_entity
        end
      end

      def destroy
        @country.destroy
      end

      private

      def set_country
        @country = Country.find(params[:id])
      end

      def country_params
        params.require(:country).permit(%i[name])
      end

      def authorize_country!
        authorize(@country || Country)
      end
    end
  end
end
