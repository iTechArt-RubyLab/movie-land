require 'rails_helper'

RSpec.describe Api::V1::PersonReportsController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: 'api/v1/person-reports').to route_to('api/v1/person_reports#index')
    end

    it 'routes to #show' do
      expect(get: 'api/v1/people/1/person-report').to route_to('api/v1/person_reports#show', person_id: '1')
    end
  end
end
