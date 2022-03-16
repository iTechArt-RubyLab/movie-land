module Movies
  class FindService < ApplicationService
    RELATED_ENTITIES = %i[companies_movies companies countries_movies
                          countries genres_movies genres languages_movies
                          languages movies_tags tags movie_awards comments].freeze

    def initialize(options = { filter: nil, page: nil, order: nil, top: nil })
      @filter = options[:filter]
      @page = options[:page]
      @order = options[:order]
      @top = options[:top]
    end

    def call
      if filter.present?
        Movie
          .includes(RELATED_ENTITIES)
          .where('name ILIKE ?', "%#{Movie.send(:sanitize_sql_like, filter)}%")
          .paginate(page: page)
          .order("name #{order}")
      elsif top.present?
        Movie
          .includes(RELATED_ENTITIES)
          .sort_by { |movie| movie&.average_rating }
          .reverse.take(top.to_i)
      else
        Movie
          .includes(RELATED_ENTITIES)
          .paginate(page: page)
          .order("name #{order}")
      end
    end

    private

    attr_reader :filter, :page, :top

    def order
      @order ||= 'asc'
    end
  end
end
