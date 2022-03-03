require 'rails_helper'

RSpec.describe Api::V1::PermissionsController, type: :routing do
  describe 'routing' do
    it 'routes to #show' do
      expect(get: 'api/v1/roles/1/permissions').to route_to('api/v1/permissions#show', role_id: '1')
    end

    it 'routes to #create' do
      expect(post: 'api/v1/roles/1/permissions').to route_to('api/v1/permissions#create', role_id: '1')
    end

    it 'routes to #update via PUT' do
      expect(put: 'api/v1/roles/1/permissions').to route_to('api/v1/permissions#update', role_id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: 'api/v1/roles/1/permissions').to route_to('api/v1/permissions#update', role_id: '1')
    end
  end
end
