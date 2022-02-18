class CountriesController < ApplicationController
  def index
    @countries = Country.paginate(page: params[:page], per_page: 10)

    render json: @countries
  end

  def show
    render json: @country
  end

  def create
    @country = Country.new(country_params)

    if @country.save
      render json: @country, status: :created, location: @country
    else
      render json: @country.errors, status: :unprocessable_entity
    end
  end

  def update
    if @country.update(country_params)
      render json: @country
    else
      render json: @country.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @country.destroy
  end

  private

  def set_country
    @country = Country.find(params[:id])
  end

  def country_params
    params.require(:country).permit(:title, :page)
  end
end
