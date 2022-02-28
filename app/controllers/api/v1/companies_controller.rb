module Api
  module V1
    class CompaniesController < ApplicationController
      before_action :set_company, only: %i[update destroy]

      def index
        @companies = Dictionary::FindService.new(Company, params).call

        render json: @companies, each_serializer: DictionarySerializer
      end

      def create
        @company = Company.new(company_params)

        if @company.save
          render json: @company, status: :created, serializer: DictionarySerializer
        else
          render json: @company.errors, status: :unprocessable_entity
        end
      end

      def update
        if @company.update(company_params)
          render json: @company, serializer: DictionarySerializer
        else
          render json: @company.errors, status: :unprocessable_entity
        end
      end

      def destroy
        @company.destroy
      end

      private

      def set_company
        @company = Company.find(params[:id])
      end

      def company_params
        params.require(:company).permit(%i[name])
      end
    end
  end
end
