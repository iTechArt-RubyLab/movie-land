require 'swagger_helper'

RSpec.describe 'api/v1/movies', type: :request do
  let(:user) { create :user, :admin }
  let(:valid_headers) { sign_in user }

  let(:'access-token') { valid_headers['access-token'] }
  let(:client) { valid_headers['client'] }
  let(:uid) { valid_headers['uid'] }

  path '/api/v1/movies' do
    get 'Retrieves all movies.' do
      tags 'Movies'
      produces 'application/json'

      response '200', 'Movies found.' do
        let(:movie) { create :movie }

        include_context 'with integration test'
      end
    end

    post 'Create a movie.' do
      tags 'Movies'
      consumes 'application/json'
      parameter name: 'access-token', in: :header, type: :string, required: true
      parameter name: 'client', in: :header, type: :string, required: true
      parameter name: 'uid', in: :header, type: :string, required: true
      parameter name: :params, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          description: { type: :text },
          tagline: { type: :string },
          trailer: { type: :string },
          release_date: { type: :date },
          age_limit: { type: :integer },
          budget: { type: :integer },
          duration: { type: :integer },
          poster: { type: :hash },
          images: { type: :array, items: { type: :hash } }
        },
        required: %w[name description tagline trailer release_date age_limit budget duration
                     poster images]
      }
      produces 'application/json'

      response '201', 'Movie created.' do
        let(:params) { attributes_for :movie }

        include_context 'with integration test'
      end

      response '401', 'You are not authorized.' do
        let(:'access-token') { 'invalid' }
        let(:client) { 'invalid' }
        let(:uid) { 'invalid' }

        let(:params) { attributes_for :movie }

        include_context 'with integration test'
      end

      response '422', 'Movie creation failed.' do
        let(:params) { { movie: { name: 'invalid' } } }

        include_context 'with integration test'
      end
    end
  end

  path '/api/v1/movies/{id}' do
    get 'Retrieves a movie.' do
      tags 'Movies'
      produces 'application/json'
      parameter name: :id, in: :path, type: :string

      response '200', 'Movie found.' do
        let(:id) { create(:movie).id }

        include_context 'with integration test'
      end

      response '404', 'Movie not found.' do
        let(:id) { -1 }

        include_context 'with integration test'
      end
    end

    put 'Update movie.' do
      tags 'Movies'
      consumes 'application/json'
      parameter name: 'access-token', in: :header, type: :string, required: true
      parameter name: 'client', in: :header, type: :string, required: true
      parameter name: 'uid', in: :header, type: :string, required: true
      parameter name: :id, in: :path, type: :string, required: true
      parameter name: :params, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          description: { type: :text },
          tagline: { type: :string },
          trailer: { type: :string },
          release_date: { type: :date },
          age_limit: { type: :integer },
          budget: { type: :integer },
          duration: { type: :integer },
          poster: { type: :hash },
          images: { type: :array, items: { type: :hash } }
        },
        required: %w[name description tagline trailer release_date age_limit budget duration
                     poster images]
      }
      produces 'application/json'

      response '200', 'Movie updated.' do
        schema type: :object,
               properties: {
                 id: { type: :integer },
                 name: { type: :string },
                 description: { type: :text },
                 tagline: { type: :string },
                 trailer: { type: :string },
                 release_date: { type: :date },
                 age_limit: { type: :integer },
                 budget: { type: :integer },
                 duration: { type: :integer },
                 poster: { type: :hash },
                 images: { type: :array, items: { type: :hash } }
               },
               required: %w[id name description tagline trailer release_date age_limit budget duration
                            poster images]

        let(:id) { create(:movie).id }
        let(:params) { attributes_for :movie }

        include_context 'with integration test'
      end

      response '401', 'You are not authorized.' do
        let(:'access-token') { 'invalid' }
        let(:client) { 'invalid' }
        let(:uid) { 'invalid' }

        let(:id) { create(:movie).id }
        let(:params) { attributes_for :movie }

        include_context 'with integration test'
      end

      response '404', 'Movie not found.' do
        let(:id) { -1 }
        let(:params) { {} }

        include_context 'with integration test'
      end
    end

    delete 'Delete movie.' do
      tags 'Movies'
      consumes 'application/json'
      parameter name: 'access-token', in: :header, type: :string, required: true
      parameter name: 'client', in: :header, type: :string, required: true
      parameter name: 'uid', in: :header, type: :string, required: true
      parameter name: :id, in: :path, type: :string, required: true
      produces 'application/json'

      response '204', 'Movie deleted successfully.' do
        let(:id) { create(:movie).id }

        run_test!
      end

      response '401', 'You are not authorized.' do
        let(:'access-token') { 'invalid' }
        let(:client) { 'invalid' }
        let(:uid) { 'invalid' }

        let(:id) { create(:movie).id }

        run_test!
      end

      response '404', 'Movie not found.' do
        let(:id) { -1 }

        run_test!
      end
    end
  end
end
