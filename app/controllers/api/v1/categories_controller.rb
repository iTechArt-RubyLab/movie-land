module Api
  module V1
    class CategoriesController < ApplicationController
      before_action :set_category, only: %i[update destroy]

      def index
        @categories = CategoryService.new(params).call

        render json: @categories, each_serializer: CategorySerializer
      end

      def create
        @category = Award.find(params[:award_id]).categories.build(category_params)

        if @category.save
          render json: @category, status: :created, serializer: CategorySerializer
        else
          render json: @category.errors, status: :unprocessable_entity
        end
      end

      def update
        if @category.update(category_params)
          render json: @category, serializer: CategorySerializer
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
    end
  end
end
