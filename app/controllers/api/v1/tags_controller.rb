module Api
  module V1
    class TagsController < ApplicationController
      def index
        @tags = Dictionary::FindService.new(Tag, params).call

        render json: @tags, each_serializer: DictionarySerializer
      end
    end
  end
end
