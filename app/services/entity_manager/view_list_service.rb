module EntityManager
  class ViewListService < ApplicationService
    def initialize(params = {})
      @user = params[:user]
      @params = params[:attributes]
    end

    def call
      if params[:filter].present?
        ViewList.where(watching_status: params[:filter])
                .where(user: user)
                .paginate(page: params[:page])
                .order("watching_status #{order}")
      else
        ViewList.where(user: user).paginate(page: params[:page]).order("watching_status #{order}")
      end
    end

    private

    attr_reader :user, :params

    def order
      params[:order].presence || 'asc'
    end
  end
end
