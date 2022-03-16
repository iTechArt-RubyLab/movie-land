module Dictionary
  class FindService < ApplicationService
    def initialize(class_name, options = { filter: nil, page: nil, order: nil, name: nil })
      @class_name = class_name
      @filter = options[:filter]
      @page = options[:page]
      @order = options[:order]
      @name = options[:name]
    end

    def call
      if filter.present?
        class_name.where('name ILIKE ?', "%#{filter}%").paginate(page: page).order("name #{order}")
      else
        class_name.paginate(page: page).order("name #{order}")
      end
    end

    private

    attr_reader :class_name, :filter, :page, :name

    def order
      @order ||= 'asc'
    end
  end
end
