module Ratings
  class FindService < ApplicationService
    def initialize(user, options = { page: nil, order: nil })
      @user = user
      @page = options[:page]
      @order = options[:order]
    end

    def call
      Rating.where(user: user).paginate(page: page).order("rating #{order}")
    end

    private

    attr_reader :user, :page

    def order
      @order ||= 'asc'
    end
  end
end
