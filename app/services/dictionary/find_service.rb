module Dictionary
  class FindService < ApplicationService
    def initialize(class_name, params)
      @class_name = class_name
      @params = params
    end

    def call
      if params[:filter].present?
        class_name.where('name ILIKE ?', "%#{params[:filter]}%").paginate(page: params[:page]).order("name #{order}")
      else
        class_name.paginate(page: params[:page]).order("name #{order}")
      end
    end

    private

    attr_reader :class_name, :params

    def order
      params[:order].presence || 'asc'
    end
  end
end
