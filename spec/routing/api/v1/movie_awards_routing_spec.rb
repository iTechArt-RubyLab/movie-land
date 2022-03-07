require 'rails_helper'

RSpec.describe Api::V1::MovieAwardsController, type: :routing do
  describe 'routing' do
    it 'routes to #show' do
      expect(get: 'api/v1/movies/1/movie_awards/1').to route_to('api/v1/movie_awards#show', id: '1', movie_id: '1')
    end

    it 'routes to #create' do
      expect(post: 'api/v1/movies/1/movie_awards').to route_to('api/v1/movie_awards#create', movie_id: '1')
    end

    it 'routes to #update via PUT' do
      expect(put: 'api/v1/movies/1/movie_awards/1').to route_to('api/v1/movie_awards#update', id: '1', movie_id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: 'api/v1/movies/1/movie_awards/1').to route_to('api/v1/movie_awards#update', id: '1', movie_id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: 'api/v1/movies/1/movie_awards/1').to route_to('api/v1/movie_awards#destroy', id: '1',
                                                                                                  movie_id: '1')
    end
  end
end
