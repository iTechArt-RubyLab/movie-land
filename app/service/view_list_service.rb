class ViewListService
  def initialize(class_name, params = {})
    @class_name = class_name
    @user = params[:user]
    @params = params[:attributes]
  end

  def call
    if params[:filter].present?
      class_name.where(watching_status: params[:filter])
                .where(user: user)
                .paginate(page: params[:page])
                .order("watching_status #{order}")
    else
      class_name.where(user: user).paginate(page: params[:page]).order("watching_status #{order}")
    end
  end

  private

  attr_reader :class_name, :params, :user

  def order
    params[:order].presence || 'asc'
  end
end
