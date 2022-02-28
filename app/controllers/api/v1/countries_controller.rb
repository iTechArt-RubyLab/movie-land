module Api
  module V1
    class CountriesController < ApplicationController
      before_action :set_country, only: %i[update destroy]

      def index
        @countries = Dictionary::FindService.new(Country, params).call

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
    end
  end
end
