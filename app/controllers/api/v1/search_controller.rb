module Api
  module V1
    class SearchController < ApplicationController
      def index
        search_result = Search::Autocompleter.call(params[:query].to_s)

        render json: search_result, status: :found
      end
    end
  end
end
