require 'rails_helper'

RSpec.describe Api::V1::RatingsController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/api/v1/ratings').to route_to('api/v1/ratings#index')
    end

    it 'routes to #create' do
      expect(post: '/api/v1/ratings').to route_to('api/v1/ratings#create')
    end

    it 'routes to #update via PUT' do
      expect(put: '/api/v1/ratings/1').to route_to('api/v1/ratings#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/api/v1/ratings/1').to route_to('api/v1/ratings#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/api/v1/ratings/1').to route_to('api/v1/ratings#destroy', id: '1')
    end
  end
end
