module Awards
  class FindService < ApplicationService
    def initialize(options = { filter: nil, page: nil, order: nil })
      @filter = options[:filter]
      @page = options[:page]
      @order = options[:order]
    end

    def call
      if filter.present?
        Award.includes(%i[categories country])
             .where('name ILIKE ?', "%#{filter}%")
             .paginate(page: page)
             .order("name #{order}")
      else
        Award.includes(%i[categories country]).paginate(page: page).order("name #{order}")
      end
    end

    private

    attr_reader :filter, :page

    def order
      @order ||= 'asc'
    end
  end
end
