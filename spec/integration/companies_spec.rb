require 'swagger_helper'

RSpec.describe 'api/v1/companies', type: :request do
  let(:user) { create :user, :admin }
  let(:valid_headers) { sign_in user }

  let(:'access-token') { valid_headers['access-token'] }
  let(:client) { valid_headers['client'] }
  let(:uid) { valid_headers['uid'] }

  path '/api/v1/companies' do
    get 'Retrieves all companies.' do
      tags 'Companies'
      produces 'application/json'
      parameter name: 'access-token', in: :header, type: :string, required: true
      parameter name: 'client', in: :header, type: :string, required: true
      parameter name: 'uid', in: :header, type: :string, required: true

      response '200', 'Companies found.' do
        let(:company) { create :company }

        include_context 'with integration test'
      end

      response '401', 'You are not authorized.' do
        let(:'access-token') { 'invalid' }
        let(:client) { 'invalid' }
        let(:uid) { 'invalid' }

        let(:company) { create :company }

        include_context 'with integration test'
      end
    end

    post 'Create company.' do
      tags 'Companies'
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

      response '201', 'Company created.' do
        let(:params) { attributes_for(:company) }

        include_context 'with integration test'
      end

      response '401', 'You are not authorized.' do
        let(:'access-token') { 'invalid' }
        let(:client) { 'invalid' }
        let(:uid) { 'invalid' }

        let(:params) { attributes_for(:company) }

        include_context 'with integration test'
      end

      response '422', 'Company creation failed validation.' do
        let(:params) { { company: { name: 0 } } }

        include_context 'with integration test'
      end
    end
  end

  path '/api/v1/companies/{id}' do
    put 'Update company.' do
      tags 'Companies'
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

      response '200', 'Company updated.' do
        schema type: :object,
               properties: {
                 id: { type: :integer },
                 name: { type: :string }
               },
               required: %w[id name]

        let(:id) { create(:company).id }
        let(:params) { attributes_for :company }

        include_context 'with integration test'
      end

      response '401', 'You are not authorized.' do
        let(:'access-token') { 'invalid' }
        let(:client) { 'invalid' }
        let(:uid) { 'invalid' }

        let(:id) { create(:company).id }
        let(:params) { attributes_for :company }

        include_context 'with integration test'
      end

      response '404', 'Company not found.' do
        let(:id) { -1 }
        let(:params) { {} }

        include_context 'with integration test'
      end
    end

    delete 'Delete company.' do
      tags 'Companies'
      consumes 'application/json'
      parameter name: 'access-token', in: :header, type: :string, required: true
      parameter name: 'client', in: :header, type: :string, required: true
      parameter name: 'uid', in: :header, type: :string, required: true
      parameter name: :id, in: :path, type: :string, required: true
      produces 'application/json'

      response '204', 'Company deleted successfully.' do
        let(:id) { create(:company).id }

        run_test!
      end

      response '401', 'You are not authorized.' do
        let(:'access-token') { 'invalid' }
        let(:client) { 'invalid' }
        let(:uid) { 'invalid' }

        let(:id) { create(:company).id }

        run_test!
      end

      response '404', 'Company not found.' do
        let(:id) { -1 }

        run_test!
      end
    end
  end
end
