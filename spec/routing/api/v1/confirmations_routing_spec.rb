require 'rails_helper'
module Api
  module V1
    RSpec.describe DeviseTokenAuth::ConfirmationsController, type: :routing do
      describe 'routing' do
        it 'routes to #create' do
          expect(post: 'api/v1/auth/confirmation').to route_to('devise_token_auth/confirmations#create')
        end
      end
    end
  end
end
