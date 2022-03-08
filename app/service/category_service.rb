class CategoryService
  def initialize(params)
    @params = params
  end

  def call
    if params[:filter].present?
      Category.where('award_id = ? && name ILIKE ?', params[:award_id], "%#{params[:filter]}%")
              .paginate(page: params[:page]).order("name #{order}")
    else
      Category.where(award_id: params[:award_id]).paginate(page: params[:page]).order("name #{order}")
    end
  end

  private

  attr_reader :params

  def order
    params[:order].presence || 'asc'
  end
end
