require 'rails_helper'

RSpec.describe DeviseTokenAuth::RegistrationsController, type: :routing do
  describe 'routing' do
    it 'routes to #create' do
      expect(post: 'auth').to route_to('devise_token_auth/registrations#create')
    end

    it 'routes to #update via PUT' do
      expect(put: 'auth').to route_to('devise_token_auth/registrations#update')
    end

    it 'routes to #destroy' do
      expect(delete: 'auth').to route_to('devise_token_auth/registrations#destroy')
    end
  end
end
