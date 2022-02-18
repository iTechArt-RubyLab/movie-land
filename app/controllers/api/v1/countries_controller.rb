module Api
  module V1
    class CountriesController < ApplicationController
      before_action :set_country, only: %i[show update destroy]

      def index
        @countries = Country.paginate(page: params[:page], per_page: 10)

        render json: @countries, each_serializer: CountrySerializer
      end

      def show
        render json: @country
      end

      def create
        @country = Country.new(country_params)

        if @country.save
          render json: @country, status: :created
        else
          render json: @country.errors, status: :unprocessable_entity
        end
      end

      def update
        if @country.update(country_params)
          render json: @country
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
        params.require(:country).permit(%i[title])
      end
    end
  end
end
