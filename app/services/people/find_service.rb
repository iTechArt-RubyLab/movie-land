module People
  class FindService < ApplicationService
    def initialize(params)
      @params = params
    end

    def call
      if params[:filter].present?
        Person
          .includes(:country)
          .where('name ILIKE ? OR surname ILIKE ? ', "%#{params[:filter]}%", "%#{params[:filter]}%")
          .paginate(page: params[:page])
          .order("name #{order}")
      else
        Person.includes(:country).paginate(page: params[:page]).order("name #{order}")
      end
    end

    private

    attr_reader :params

    def order
      params[:order].presence || 'asc'
    end
  end
end
