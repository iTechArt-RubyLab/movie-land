class RatingService
  def initialize(class_name, params = {})
    @class_name = class_name
    @user = params[:user]
    @params = params[:attributes]
  end

  def call
    class_name.where(user: user).paginate(page: params[:page]).order("rating #{order}")
  end

  private

  attr_reader :class_name, :user, :params

  def order
    params[:order].presence || 'asc'
  end
end
