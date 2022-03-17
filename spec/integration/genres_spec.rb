require 'swagger_helper'

RSpec.describe 'api/v1/genres', type: :request do
  let(:user) { create :user, :admin }
  let(:valid_headers) { sign_in user }

  let(:'access-token') { valid_headers['access-token'] }
  let(:client) { valid_headers['client'] }
  let(:uid) { valid_headers['uid'] }

  path '/api/v1/genres' do
    get 'Retrieves all genres.' do
      tags 'Genres'
      produces 'application/json'
      parameter name: 'access-token', in: :header, type: :string, required: true
      parameter name: 'client', in: :header, type: :string, required: true
      parameter name: 'uid', in: :header, type: :string, required: true

      response '200', 'Genres found.' do
        let(:genre) { create :genre }

        include_context 'with integration test'
      end

      response '401', 'You are not authorized.' do
        let(:'access-token') { 'invalid' }
        let(:client) { 'invalid' }
        let(:uid) { 'invalid' }

        let(:genre) { create :genre }

        include_context 'with integration test'
      end
    end

    post 'Create genre.' do
      tags 'Genres'
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

      response '201', 'Genre created.' do
        let(:params) { attributes_for :genre }

        include_context 'with integration test'
      end

      response '401', 'You are not authorized.' do
        let(:'access-token') { 'invalid' }
        let(:client) { 'invalid' }
        let(:uid) { 'invalid' }

        let(:params) { attributes_for :genre }

        include_context 'with integration test'
      end

      response '422', 'Genre creation failed validation.' do
        let(:params) { { genre: { name: 0 } } }

        include_context 'with integration test'
      end
    end
  end

  path '/api/v1/genres/{id}' do
    put 'Update genre.' do
      tags 'Genres'
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

      response '200', 'Genre updated.' do
        schema type: :object,
               properties: {
                 id: { type: :integer },
                 name: { type: :string }
               },
               required: %w[id name]

        let(:id) { create(:genre).id }
        let(:params) { attributes_for :genre }

        include_context 'with integration test'
      end

      response '401', 'You are not authorized.' do
        let(:'access-token') { 'invalid' }
        let(:client) { 'invalid' }
        let(:uid) { 'invalid' }

        let(:id) { create(:genre).id }
        let(:params) { attributes_for :genre }

        include_context 'with integration test'
      end

      response '404', 'Genre not found.' do
        let(:id) { -1 }
        let(:params) { {} }

        include_context 'with integration test'
      end
    end

    delete 'Delete genre.' do
      tags 'Genres'
      consumes 'application/json'
      parameter name: 'access-token', in: :header, type: :string, required: true
      parameter name: 'client', in: :header, type: :string, required: true
      parameter name: 'uid', in: :header, type: :string, required: true
      parameter name: :id, in: :path, type: :string, required: true
      produces 'application/json'

      response '204', 'Genre deleted successfully.' do
        let(:id) { create(:genre).id }

        run_test!
      end

      response '401', 'You are not authorized.' do
        let(:'access-token') { 'invalid' }
        let(:client) { 'invalid' }
        let(:uid) { 'invalid' }

        let(:id) { create(:genre).id }

        run_test!
      end

      response '404', 'Genre not found.' do
        let(:id) { -1 }

        run_test!
      end
    end
  end
end
