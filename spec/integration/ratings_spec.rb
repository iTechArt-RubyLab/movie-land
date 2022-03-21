require 'swagger_helper'

RSpec.describe 'api/v1/my-ratings', type: :request do
  let!(:user) { create :user, :reviewer }
  let(:valid_headers) { sign_in user }

  let(:'access-token') { valid_headers['access-token'] }
  let(:client) { valid_headers['client'] }
  let(:uid) { valid_headers['uid'] }
  let!(:movie) { create :movie }

  path '/api/v1/my-ratings' do
    get 'Retrieves all ratings.' do
      tags 'Ratings'
      parameter name: 'access-token', in: :header, type: :string, required: true
      parameter name: 'client', in: :header, type: :string, required: true
      parameter name: 'uid', in: :header, type: :string, required: true
      produces 'application/json'

      response '200', 'My ratings.' do
        let(:rating) { create :rating }

        include_context 'with integration test'
      end

      response '401', 'You are not authorized.' do
        let(:'access-token') { 'invalid' }
        let(:client) { 'invalid' }
        let(:uid) { 'invalid' }

        let(:rating) { create :rating }

        include_context 'with integration test'
      end
    end

    post 'Create a rating.' do
      tags 'Ratings'
      consumes 'application/json'
      parameter name: 'access-token', in: :header, type: :string, required: true
      parameter name: 'client', in: :header, type: :string, required: true
      parameter name: 'uid', in: :header, type: :string, required: true
      parameter name: :params, in: :body, schema: {
        type: :object,
        properties: {
          rating: {
            type: :object,
            properties: {
              rating: { type: :integer },
              movie_id: { type: :integer }
            },
            required: %w[rating movie_id]
          }
        },
        required: [:rating]
      }
      produces 'application/json'

      response '201', 'Rating created.' do
        let(:params) { { rating: attributes_for(:rating, user_id: user.id, movie_id: movie.id) } }

        include_context 'with integration test'
      end

      response '401', 'You are not authorized.' do
        let(:'access-token') { 'invalid' }
        let(:client) { 'invalid' }
        let(:uid) { 'invalid' }

        let(:params) { { rating: attributes_for(:rating, user_id: user.id, movie_id: movie.id) } }

        include_context 'with integration test'
      end

      response '422', 'Rating creation failed.' do
        let(:params) { { rating: { rating: 'invalid' } } }

        include_context 'with integration test'
      end
    end
  end

  path '/api/v1/my-ratings/{id}' do
    put 'Update rating.' do
      tags 'Ratings'
      consumes 'application/json'
      parameter name: 'access-token', in: :header, type: :string, required: true
      parameter name: 'client', in: :header, type: :string, required: true
      parameter name: 'uid', in: :header, type: :string, required: true
      parameter name: :id, in: :path, type: :string, required: true
      parameter name: :params, in: :body, schema: {
        type: :object,
        properties: {
          rating: {
            type: :object,
            properties: {
              rating: { type: :integer },
              movie_id: { type: :integer }
            },
            required: %w[rating movie_id]
          }
        },
        required: [:rating]
      }
      produces 'application/json'

      response '200', 'Rating updated.' do
        schema type: :object,
               properties: {
                 id: { type: :integer },
                 rating: { type: :integer },
                 movie: { type: :object }
               },
               required: %w[id rating movie]

        let(:id) { create(:rating).id }
        let(:params) { { rating: attributes_for(:rating, user_id: user.id, movie_id: movie.id) } }

        include_context 'with integration test'
      end

      response '401', 'You are not authorized.' do
        let(:'access-token') { 'invalid' }
        let(:client) { 'invalid' }
        let(:uid) { 'invalid' }

        let(:id) { create(:rating).id }
        let(:params) { { rating: attributes_for(:rating, user_id: user.id, movie_id: movie.id) } }

        include_context 'with integration test'
      end

      response '404', 'Rating not found.' do
        let(:id) { -1 }
        let(:params) { {} }

        include_context 'with integration test'
      end
    end

    delete 'Delete rating.' do
      tags 'Ratings'
      consumes 'application/json'
      parameter name: 'access-token', in: :header, type: :string, required: true
      parameter name: 'client', in: :header, type: :string, required: true
      parameter name: 'uid', in: :header, type: :string, required: true
      parameter name: :id, in: :path, type: :string, required: true
      produces 'application/json'

      response '204', 'Rating deleted successfully.' do
        let(:id) { create(:rating).id }

        run_test!
      end

      response '401', 'You are not authorized.' do
        let(:'access-token') { 'invalid' }
        let(:client) { 'invalid' }
        let(:uid) { 'invalid' }

        let(:id) { create(:rating).id }

        run_test!
      end

      response '404', 'Rating not found.' do
        let(:id) { -1 }

        run_test!
      end
    end
  end
end
