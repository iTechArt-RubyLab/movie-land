require 'swagger_helper'

RSpec.describe 'api/v1/countries', type: :request do
  let(:user) { create :user, :admin }
  let(:valid_headers) { sign_in user }

  let(:'access-token') { valid_headers['access-token'] }
  let(:client) { valid_headers['client'] }
  let(:uid) { valid_headers['uid'] }

  path '/api/v1/countries' do
    get 'Retrieves all countries.' do
      tags 'Countries'
      produces 'application/json'
      parameter name: 'access-token', in: :header, type: :string, required: true
      parameter name: 'client', in: :header, type: :string, required: true
      parameter name: 'uid', in: :header, type: :string, required: true

      response '200', 'Countries found.' do
        let(:country) { create :country }

        include_context 'with integration test'
      end

      response '401', 'You are not authorized.' do
        let(:'access-token') { 'invalid' }
        let(:client) { 'invalid' }
        let(:uid) { 'invalid' }

        let(:country) { create :country }

        include_context 'with integration test'
      end
    end

    post 'Create country.' do
      tags 'Countries'
      consumes 'application/json'
      parameter name: 'access-token', in: :header, type: :string, required: true
      parameter name: 'client', in: :header, type: :string, required: true
      parameter name: 'uid', in: :header, type: :string, required: true
      parameter name: :params, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string }
        },
        required: [:name]
      }
      produces 'application/json'

      response '201', 'Country created.' do
        let(:params) { attributes_for :country }

        include_context 'with integration test'
      end

      response '401', 'You are not authorized.' do
        let(:'access-token') { 'invalid' }
        let(:client) { 'invalid' }
        let(:uid) { 'invalid' }

        let(:params) { attributes_for :country }

        include_context 'with integration test'
      end

      response '422', 'Country creation failed validation.' do
        let(:params) { { country: { name: 0 } } }

        include_context 'with integration test'
      end
    end
  end

  path '/api/v1/countries/{id}' do
    put 'Update country.' do
      tags 'Countries'
      consumes 'application/json'
      parameter name: 'access-token', in: :header, type: :string, required: true
      parameter name: 'client', in: :header, type: :string, required: true
      parameter name: 'uid', in: :header, type: :string, required: true
      parameter name: :id, in: :path, type: :string, required: true
      parameter name: :params, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string }
        },
        required: [:name]
      }
      produces 'application/json'

      response '200', 'Country updated.' do
        schema type: :object,
               properties: {
                 id: { type: :integer },
                 name: { type: :string }
               },
               required: %w[id name]

        let(:id) { create(:country).id }
        let(:params) { attributes_for :country }

        include_context 'with integration test'
      end

      response '401', 'You are not authorized.' do
        let(:'access-token') { 'invalid' }
        let(:client) { 'invalid' }
        let(:uid) { 'invalid' }

        let(:id) { create(:country).id }
        let(:params) { attributes_for :country }

        include_context 'with integration test'
      end

      response '404', 'Country not found.' do
        let(:id) { -1 }
        let(:params) { {} }

        include_context 'with integration test'
      end
    end

    delete 'Delete country.' do
      tags 'Countries'
      consumes 'application/json'
      parameter name: 'access-token', in: :header, type: :string, required: true
      parameter name: 'client', in: :header, type: :string, required: true
      parameter name: 'uid', in: :header, type: :string, required: true
      parameter name: :id, in: :path, type: :string, required: true
      produces 'application/json'

      response '204', 'Country deleted successfully.' do
        let(:id) { create(:country).id }

        run_test!
      end

      response '401', 'You are not authorized.' do
        let(:'access-token') { 'invalid' }
        let(:client) { 'invalid' }
        let(:uid) { 'invalid' }

        let(:id) { create(:country).id }

        run_test!
      end

      response '404', 'Country not found.' do
        let(:id) { -1 }

        run_test!
      end
    end
  end
end
