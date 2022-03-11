require 'rails_helper'

RSpec.describe Api::V1::CategoriesController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: 'api/v1/awards/1/categories').to route_to('api/v1/categories#index', award_id: '1')
    end

    it 'routes to #create' do
      expect(post: 'api/v1/awards/1/categories').to route_to('api/v1/categories#create', award_id: '1')
    end

    it 'routes to #update via PUT' do
      expect(put: 'api/v1/awards/1/categories/1').to route_to('api/v1/categories#update', award_id: '1', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: 'api/v1/awards/1/categories/1').to route_to('api/v1/categories#update', award_id: '1', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: 'api/v1/awards/1/categories/1').to route_to('api/v1/categories#destroy', award_id: '1', id: '1')
    end
  end
end
