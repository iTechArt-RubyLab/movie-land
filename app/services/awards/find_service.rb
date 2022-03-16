module Awards
  class FindService < ApplicationService
    def initialize(params)
      @params = params
    end

    def call
      if params[:filter].present?
        Award.includes(%i[categories country])
             .where('name ILIKE ?', "%#{params[:filter]}%")
             .paginate(page: params[:page])
             .order("name #{order}")
      else
        Award.includes(%i[categories country]).paginate(page: params[:page]).order("name #{order}")
      end
    end

    private

    attr_reader :params

    def order
      params[:order].presence || 'asc'
    end
  end
end
