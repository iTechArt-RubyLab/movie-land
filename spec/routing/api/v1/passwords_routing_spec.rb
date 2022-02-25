require 'rails_helper'
module Api
  module V1
    RSpec.describe DeviseTokenAuth::PasswordsController, type: :routing do
      describe 'routing' do
        it 'routes to #create' do
          expect(post: 'api/v1/auth/password').to route_to('devise_token_auth/passwords#create')
        end

        it 'routes to #update via PUT' do
          expect(put: 'api/v1/auth/password').to route_to('devise_token_auth/passwords#update')
        end
      end
    end
  end
end
