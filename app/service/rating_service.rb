class RatingService
  def initialize(class_name, params, current_user)
    @class_name = class_name
    @params = params
    @current_user = current_user
  end

  def call
    class_name.where(user_id: current_user.id).paginate(page: params[:page]).order("rating #{order}")
  end

  private

  attr_accessor :class_name, :params, :current_user

  def order
    params[:order].presence || 'asc'
  end
end
