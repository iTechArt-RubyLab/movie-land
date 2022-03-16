module Categories
  class FindService < ApplicationService
    def initialize(options = { filter: nil, page: nil, order: nil, award_id: nil })
      @filter = options[:filter]
      @page = options[:page]
      @order = options[:order]
      @award_id = options[:award_id]
    end

    def call
      if filter.present?
        Category.where('award_id = ? AND name ILIKE ?', award_id, "%#{Category.send(:sanitize_sql_like, filter)}%")
                .paginate(page: page).order("name #{order}")
      else
        Category.where(award_id: award_id).paginate(page: page).order("name #{order}")
      end
    end

    private

    attr_reader :filter, :page, :award_id

    def order
      @order ||= 'asc'
    end
  end
end
