module EntityManager
  class RoleService < ApplicationService
    def initialize(params)
      @params = params
    end

    def call
      if params[:filter].present?
        Role
          .includes(:permission)
          .where('name ILIKE ?', "%#{params[:filter]}%")
          .paginate(page: params[:page])
          .order("name #{order}")
      else
        Role.includes(:permission).paginate(page: params[:page]).order("name #{order}")
      end
    end

    private

    attr_reader :params

    def order
      params[:order].presence || 'asc'
    end
  end
end
