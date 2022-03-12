module Api
  module V1
    class TagsController < ApplicationController
      before_action :authorize_tag!
      after_action :verify_authorized

      def index
        @tags = Dictionary::FindService.call(Tag, params)

        render json: @tags, each_serializer: DictionarySerializer
      end

      private

      def authorize_tag!
        authorize(@tags || Tag)
      end
    end
  end
end
