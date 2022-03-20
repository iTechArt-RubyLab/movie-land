module MovieAwards
  class FindService < ApplicationService
    def initialize(options = { page: nil, order: nil, movie_id: nil })
      @page = options[:page]
      @order = options[:order]
      @movie_id = options[:movie_id]
    end

    def call
      MovieAward.where(movie_id: movie_id).paginate(page: page).order("delivery_year #{order}")
    end

    private

    attr_reader :page, :movie_id

    def order
      @order ||= 'asc'
    end
  end
end
