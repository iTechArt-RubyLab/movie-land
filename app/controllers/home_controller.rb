class HomeController < ApplicationController
  def index
    render json: { greetings: 'Welcome to the Movie Land!' }
  end
end
