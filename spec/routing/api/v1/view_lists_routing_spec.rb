require 'rails_helper'

RSpec.describe Api::V1::ViewListsController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: 'api/v1/view_lists').to route_to('api/v1/view_lists#index')
    end

    it 'routes to #create' do
      expect(post: 'api/v1/view_lists').to route_to('api/v1/view_lists#create')
    end

    it 'routes to #update via PUT' do
      expect(put: 'api/v1/view_lists/1').to route_to('api/v1/view_lists#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: 'api/v1/view_lists/1').to route_to('api/v1/view_lists#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: 'api/v1/view_lists/1').to route_to('api/v1/view_lists#destroy', id: '1')
    end
  end
end
