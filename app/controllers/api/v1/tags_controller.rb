module Api
  module V1
    class TagsController < ApplicationController
      before_action :set_tag, only: %i[show update destroy]

      def index
        @tags = Dictionary::FindService.new(Tag, params).call

        render json: @tags, each_serializer: DictionarySerializer
      end

      def show
        render json: @tag, serializer: DictionarySerializer
      end

      def create
        @tag = Tag.new(tag_params)

        if @tag.save
          render json: @tag, status: :created, serializer: DictionarySerializer
        else
          render json: @tag.errors, status: :unprocessable_entity
        end
      end

      def update
        if @tag.update(tag_params)
          render json: @tag, serializer: DictionarySerializer
        else
          render json: @tag.errors, status: :unprocessable_entity
        end
      end

      def destroy
        @tag.destroy
      end

      private

      def set_tag
        @tag = Tag.find(params[:id])
      end

      def tag_params
        params.require(:tag).permit(%i[name])
      end
    end
  end
end
