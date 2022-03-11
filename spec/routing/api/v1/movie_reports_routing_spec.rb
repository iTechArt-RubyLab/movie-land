require 'rails_helper'

RSpec.describe Api::V1::MovieReportsController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: 'api/v1/movie-reports').to route_to('api/v1/movie_reports#index')
    end

    it 'routes to #show' do
      expect(get: 'api/v1/movies/1/movie-report').to route_to('api/v1/movie_reports#show', movie_id: '1')
    end
  end
end
