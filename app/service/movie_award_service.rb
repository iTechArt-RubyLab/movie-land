class MovieAwardService
  def initialize(params)
    @params = params
  end

  def call
    MovieAward.where(movie_id: params[:movie_id]).paginate(page: params[:page]).order("delivery_year #{order}")
  end

  private

  attr_reader :params

  def order
    params[:order].presence || 'asc'
  end
end
