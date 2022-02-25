class RatingService
  def initialize(class_name, params)
    @class_name = class_name
    @params = params
  end

  def call
    if params[:filter].present?
      class_name.where(movie_id: params[:filter]).paginate(page: params[:page]).order("movie_id #{order}")
    else
      class_name.paginate(page: params[:page]).order("rating #{order}")
    end
  end

  private

  attr_accessor :class_name, :params

  def order
    params[:order].presence || 'asc'
  end
end
