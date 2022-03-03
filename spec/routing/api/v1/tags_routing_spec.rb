require 'rails_helper'

RSpec.describe Api::V1::TagsController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: 'api/v1/tags').to route_to('api/v1/tags#index')
    end
  end
end
