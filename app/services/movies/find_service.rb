module Movies
  class FindService < ApplicationService
    RELATED_ENTITIES = %i[companies_movies companies countries_movies
                          countries genres_movies genres languages_movies
                          languages movies_tags tags movie_awards comments].freeze

    def initialize(params)
      @params = params
    end

    def call
      if params[:filter].present?
        Movie
          .includes(RELATED_ENTITIES)
          .where('name ILIKE ?', "%#{params[:filter]}%")
          .paginate(page: params[:page])
          .order("name #{order}")
      elsif params[:top].present?
        Movie
          .includes(RELATED_ENTITIES)
          .sort_by { |movie| movie&.average_rating }
          .reverse.take(params[:top].to_i)
      else
        Movie
          .includes(RELATED_ENTITIES)
          .paginate(page: params[:page])
          .order("name #{order}")
      end
    end

    private

    attr_reader :params

    def order
      params[:order].presence || 'asc'
    end
  end
end
