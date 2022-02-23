require 'rails_helper'

RSpec.describe 'Sessions', type: :request do
  let(:user) { create :confirmed_user }
  let(:valid_headers) { user.create_new_auth_token }

  describe 'when sign in' do
    context 'with valid parameters' do
      it 'responds with success' do
        post '/auth/sign_in', params: {
          email: user.email, password: user.password
        }, as: :json
        expect(response).to have_http_status(:success)
      end
    end

    context 'with invalid parameters' do
      it 'responds with unauthorized' do
        post '/auth/sign_in', params: {
          email: user.email, password: 'wrong_password'
        }, as: :json
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe 'when sign out' do
    it 'responds with success' do
      delete '/auth/sign_out', headers: valid_headers
      expect(response).to have_http_status(:success)
    end
  end
end
