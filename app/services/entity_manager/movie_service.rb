module EntityManager
  class MovieService < ApplicationService
    RELATED_ENTITIES = %i[companies_movies companies countries_movies
                          countries genres_movies genres languages_movies
                          languages movies_tags tags ratings view_lists].freeze

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
