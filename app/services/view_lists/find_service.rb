module ViewLists
  class FindService < ApplicationService
    def initialize(user, options = { filter: nil, page: nil, order: nil })
      @user = user
      @filter = options[:filter]
      @page = options[:page]
      @order = options[:order]
    end

    def call
      if filter.present?
        ViewList.where(watching_status: filter, user: user)
                .paginate(page: page)
                .order("watching_status #{order}")
      else
        ViewList.where(user: user).paginate(page: page).order("watching_status #{order}")
      end
    end

    private

    attr_reader :user, :filter, :page

    def order
      @order ||= 'asc'
    end
  end
end
