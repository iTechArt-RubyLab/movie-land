class ViewListService
  def initialize(class_name, params, current_user)
    @class_name = class_name
    @params = params
    @current_user = current_user
  end

  def call
    if params[:filter].present?
      class_name.where(watching_status: params[:filter]).where(user_id: current_user.id).paginate(page: params[:page]).order("watching_status #{order}")
    else
      class_name.where(user_id: current_user.id).paginate(page: params[:page]).order("watching_status #{order}")
    end
  end

  private

  attr_reader :class_name, :params, :current_user

  def order
    params[:order].presence || 'asc'
  end
end
