require 'swagger_helper'

RSpec.describe 'api/v1/tags', type: :request do
  before do
    sign_in user
  end

  let(:user) { create :user, :admin }
  let(:valid_headers) { user.create_new_auth_token }
  let(:'access-token') { valid_headers['access-token'] }
  let(:client) { valid_headers['client'] }
  let(:uid) { valid_headers['uid'] }

  path '/api/v1/tags' do
    get 'Retrieves all tags.' do
      tags 'Tags'
      produces 'application/json'
      parameter name: 'access-token', in: :header, type: :string, required: true
      parameter name: 'client', in: :header, type: :string, required: true
      parameter name: 'uid', in: :header, type: :string, required: true

      response '200', 'Tags found.' do
        let(:tag) { create :tag }

        include_context 'with integration test'
      end

      response '401', 'You are not authorized' do
        let(:'access-token') { 'invalid' }
        let(:client) { 'invalid' }
        let(:uid) { 'invalid' }

        let(:tag) { create :tag }

        include_context 'with integration test'
      end
    end
  end
end
