class HomeController < ApplicationController
  def index
    render json: { data: 'Hello World' }
  end

  def search
    results = Movie.search(search_params[:request], search_params)

    movies = results.map do |r|
      r.merge(r.delete('_source')).merge(id: r.delete('_id'))
    end

    render json: { movies: movies }, status: :ok
  end

  private

  def search_params
    params.permit(:request)
  end
end
