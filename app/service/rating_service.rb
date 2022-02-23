class RatingService
  def initialize(class_name, params)
    @class_name = class_name
    @params = params
  end

  def call
    class_name.paginate(page: params[:page]).order("rating #{order}")
  end

  private

  attr_accessor :class_name, :params

  def order
    params[:order].presence || 'asc'
  end
end
