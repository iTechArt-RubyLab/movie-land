class HomeController < ApplicationController
  def index
    render json: { data: 'Hello World' }
  end

  def search
    movies = Movie.search(search_params[:request], search_params).pluck(:_source)

    render json: { movies: movies }, status: :ok
  end

  private

  def search_params
    params.permit(:request)
  end
end
