require 'rails_helper'

RSpec.describe DeviseTokenAuth::PasswordsController, type: :routing do
  describe 'routing' do
    it 'routes to #create' do
      expect(post: 'auth/password').to route_to('devise_token_auth/passwords#create')
    end

    it 'routes to #update via PUT' do
      expect(put: 'auth/password').to route_to('devise_token_auth/passwords#update')
    end
  end
end
