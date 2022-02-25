require 'rails_helper'
module Api
  module V1
    RSpec.describe DeviseTokenAuth::TokenValidationsController, type: :routing do
      describe 'routing' do
        it 'routes to #index' do
          expect(get: 'api/v1/auth/validate_token').to route_to('devise_token_auth/token_validations#validate_token')
        end
      end
    end
  end
end
