module Dictionary
  class FindService
    def initialize(class_name, params)
      @class_name = class_name
      @params = params
    end

    def call
      if params[:filter].present?
        class_name.where('name LIKE ?', "%#{params[:filter]}%")
      else
        class_name.paginate(page: params[:page]).order("name #{order}")
      end
    end

    private

    attr_accessor :class_name, :params

    def order
      params[:order].present? ? params[:order] : 'asc'
    end
  end
end
