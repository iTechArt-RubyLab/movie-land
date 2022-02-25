require 'rails_helper'
module Api
  module V1
    RSpec.describe DeviseTokenAuth::SessionsController, type: :routing do
      describe 'routing' do
        it 'routes to #create' do
          expect(post: 'api/v1/auth/sign_in').to route_to('devise_token_auth/sessions#create')
        end

        it 'routes to #destroy' do
          expect(delete: 'api/v1/auth/sign_out').to route_to('devise_token_auth/sessions#destroy')
        end
      end
    end
  end
end
