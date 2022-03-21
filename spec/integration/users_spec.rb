require 'swagger_helper'

RSpec.describe 'api/v1/users', type: :request do
  let(:user) { create :user, :admin }
  let(:valid_headers) { sign_in user }

  let(:'access-token') { valid_headers['access-token'] }
  let(:client) { valid_headers['client'] }
  let(:uid) { valid_headers['uid'] }

  path '/api/v1/users' do
    get 'Retrieves all users.' do
      tags 'Users'
      produces 'application/json'
      parameter name: 'access-token', in: :header, type: :string, required: true
      parameter name: 'client', in: :header, type: :string, required: true
      parameter name: 'uid', in: :header, type: :string, required: true

      response '200', 'Users found.' do
        include_context 'with integration test'
      end
    end
  end

  path '/api/v1/users/{id}' do
    get 'Retrieves a sser.' do
      tags 'Users'
      produces 'application/json'
      parameter name: 'access-token', in: :header, type: :string, required: true
      parameter name: 'client', in: :header, type: :string, required: true
      parameter name: 'uid', in: :header, type: :string, required: true
      parameter name: :id, in: :path, type: :string, required: true

      response '200', 'User found.' do
        let(:id) { user.id }

        include_context 'with integration test'
      end

      response '404', 'User not found.' do
        let(:id) { -1 }

        include_context 'with integration test'
      end
    end

    put 'Update User.' do
      tags 'Users'
      consumes 'application/json'
      parameter name: 'access-token', in: :header, type: :string, required: true
      parameter name: 'client', in: :header, type: :string, required: true
      parameter name: 'uid', in: :header, type: :string, required: true
      parameter name: :id, in: :path, type: :string, required: true
      parameter name: :params, in: :body, schema: {
        type: :object,
        properties: {
          id: { type: :integer },
          email: { type: :string },
          username: { type: :string },
          name: { type: :string },
          surname: { type: :string },
          birthday: { type: :string, format: :date }
        },
        required: %w[id email username name surname birthday]
      }
      produces 'application/json'

      response '200', 'User updated.' do
        schema type: :object,
               properties: {
                 id: { type: :integer },
                 email: { type: :string },
                 username: { type: :string },
                 name: { type: :string },
                 surname: { type: :string },
                 birthday: { type: :date, format: :date }
               },
               required: %w[id email username name surname birthday]

        let(:id) { user.id }
        let(:params) { attributes_for :user }

        include_context 'with integration test'
      end

      response '401', 'You are not authorized.' do
        let(:'access-token') { 'invalid' }
        let(:client) { 'invalid' }
        let(:uid) { 'invalid' }

        let(:id) { user.id }
        let(:params) { attributes_for :user }

        include_context 'with integration test'
      end

      response '404', 'User not found.' do
        let(:id) { -1 }
        let(:params) { {} }

        include_context 'with integration test'
      end
    end
  end
end
