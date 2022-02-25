require 'rails_helper'
module Api
  module V1
    RSpec.describe 'Token Validations', type: :request do
      let(:user) { create :user }
      let(:valid_headers) { user.create_new_auth_token }

      describe 'when signed in' do
        it 'responds with success' do
          get '/api/v1/auth/validate_token', headers: valid_headers
          expect(response).to have_http_status(:success)
        end
      end

      describe 'when signed out' do
        it 'responds with unauthorized' do
          get '/api/v1/auth/validate_token', headers: {}
          expect(response).to have_http_status(:unauthorized)
        end
      end
    end
  end
end
