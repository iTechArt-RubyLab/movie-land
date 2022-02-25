require 'rails_helper'
module Api
  module V1
    RSpec.describe 'Confirmations', type: :request do
      let(:user) { create :user }

      describe 'POST /create' do
        it 're-sends confirmation' do
          post '/api/v1/auth/confirmation', params: { email: user.email }
          expect(response).to have_http_status(:ok)
        end
      end
    end
  end
end
