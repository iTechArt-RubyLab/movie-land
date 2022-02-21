require 'rails_helper'

RSpec.describe DeviseTokenAuth::ConfirmationsController, type: :routing do
  describe 'routing' do
    it 'routes to #create' do
      expect(post: 'auth/confirmation').to route_to('devise_token_auth/confirmations#create')
    end
  end
end
