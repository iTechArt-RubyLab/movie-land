module EntityManager
  class RatingService < ApplicationService
    def initialize(params = {})
      @user = params[:user]
      @params = params[:attributes]
    end

    def call
      Rating.where(user: user).paginate(page: params[:page]).order("rating #{order}")
    end

    private

    attr_reader :user, :params

    def order
      params[:order].presence || 'asc'
    end
  end
end
