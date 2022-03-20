module Api
  module V1
    class CategoriesController < ApplicationController
      before_action :set_category, only: %i[update destroy]
      before_action :authorize_category!
      after_action :verify_authorized

      def index
        @categories = Categories::FindService.call(params)

        render json: @categories, each_serializer: DictionarySerializer
      end

      def create
        @category = Award.find(params[:award_id]).categories.build(category_params)

        if @category.save
          render json: @category, status: :created, serializer: DictionarySerializer
        else
          render json: @category.errors, status: :unprocessable_entity
        end
      end

      def update
        if @category.update(category_params)
          render json: @category, serializer: DictionarySerializer
        else
          render json: @category.errors, status: :unprocessable_entity
        end
      end

      def destroy
        @category.destroy
      end

      private

      def set_category
        @category = Award.find(params[:award_id]).categories.find(params[:id])
      end

      def category_params
        params.require(:category).permit(:name)
      end

      def authorize_category!
        authorize(@category || Category)
      end
    end
  end
end
