module People
  class FindService < ApplicationService
    RELATED_ENTITIES = %i[country movie_staffs movies
                          comments movie_awards_person
                          movie_awards].freeze

    def initialize(options = { filter: nil, page: nil, order: nil })
      @filter = options[:filter]
      @page = options[:page]
      @order = options[:order]
    end

    def call
      if filter.present?
        Person
          .includes(RELATED_ENTITIES)
          .where('name ILIKE ?', "%#{Person.send(:sanitize_sql_like, filter)}%")
          .paginate(page: page)
          .order("name #{order}")
      else
        Person.includes(:country).paginate(page: page).order("name #{order}")
      end
    end

    private

    attr_reader :filter, :page

    def order
      @order ||= 'asc'
    end
  end
end
