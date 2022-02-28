class RatingService
  def initialize(class_name, user, params = {})
    @class_name = class_name
    @user = user
    @params = params
  end

  def call
    class_name.where(user: user).paginate(page: params[:page]).order("rating #{order}")
  end

  private

  attr_reader :class_name, :params, :user

  def order
    params[:order].presence || 'asc'
  end
end
