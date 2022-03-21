require 'swagger_helper'

RSpec.describe 'api/v1/movie_awards', type: :request do
  let(:user) { create :user, :admin }
  let(:valid_headers) { sign_in user }

  let(:'access-token') { valid_headers['access-token'] }
  let(:client) { valid_headers['client'] }
  let(:uid) { valid_headers['uid'] }
  let(:movie_id) { movie_award.movie_id }
  let(:movie_award) { create :movie_award }
  let!(:category) { create :category }

  path '/api/v1/movies/{movie_id}/movie_awards' do
    get 'Retrieves all movie awards.' do
      tags 'MovieAwards'
      produces 'application/json'
      parameter name: 'access-token', in: :header, type: :string, required: true
      parameter name: 'client', in: :header, type: :string, required: true
      parameter name: 'uid', in: :header, type: :string, required: true
      parameter name: :movie_id, in: :path, type: :string, required: true

      response '200', 'Movie awards found.' do
        include_context 'with integration test'
      end

      response '401', 'You are not authorized.' do
        let(:'access-token') { 'invalid' }
        let(:client) { 'invalid' }
        let(:uid) { 'invalid' }

        include_context 'with integration test'
      end
    end

    post 'Create a movie award.' do
      tags 'MovieAwards'
      consumes 'application/json'
      parameter name: 'access-token', in: :header, type: :string, required: true
      parameter name: 'client', in: :header, type: :string, required: true
      parameter name: 'uid', in: :header, type: :string, required: true
      parameter name: :movie_id, in: :path, type: :string, required: true
      parameter name: :params, in: :body, schema: {
        type: :object,
        properties: {
          delivery_year: { type: :integer },
          nomination_type: { type: :string },
          category_id: { type: :integer }
        },
        required: %w[delivery_year nomination_type category_id]
      }
      produces 'application/json'

      response '201', 'Movie award created.' do
        let(:params) { attributes_for :movie_award, category_id: category.id }

        include_context 'with integration test'
      end

      response '401', 'You are not authorized.' do
        let(:'access-token') { 'invalid' }
        let(:client) { 'invalid' }
        let(:uid) { 'invalid' }

        let(:params) { attributes_for :movie_award, category_id: category.id }

        include_context 'with integration test'
      end

      response '422', 'Movie award creation failed.' do
        let(:params) { { movie_award: { delivery_year: 'invalid' } } }

        include_context 'with integration test'
      end
    end
  end

  path '/api/v1/movies/{movie_id}/movie_awards/{id}' do
    get 'Retrieves a movie award.' do
      tags 'MovieAwards'
      produces 'application/json'
      parameter name: 'access-token', in: :header, type: :string, required: true
      parameter name: 'client', in: :header, type: :string, required: true
      parameter name: 'uid', in: :header, type: :string, required: true
      parameter name: :movie_id, in: :path, type: :string, required: true
      parameter name: :id, in: :path, type: :string

      response '200', 'Movie award found.' do
        let(:id) { movie_award.id }

        include_context 'with integration test'
      end

      response '404', 'Movie award not found.' do
        let(:id) { -1 }

        include_context 'with integration test'
      end
    end

    put 'Update movie.' do
      tags 'MovieAwards'
      consumes 'application/json'
      parameter name: 'access-token', in: :header, type: :string, required: true
      parameter name: 'client', in: :header, type: :string, required: true
      parameter name: 'uid', in: :header, type: :string, required: true
      parameter name: :id, in: :path, type: :string, required: true
      parameter name: :movie_id, in: :path, type: :string, required: true
      parameter name: :params, in: :body, schema: {
        type: :object,
        properties: {
          delivery_year: { type: :integer },
          nomination_type: { type: :string },
          category_id: { type: :integer }
        },
        required: %w[delivery_year nomination_type category_id]
      }
      produces 'application/json'

      response '200', 'Movie award updated.' do
        schema type: :object,
               properties: {
                 id: { type: :integer },
                 delivery_year: { type: :date },
                 nomination_type: { type: :string },
                 category: { type: :hash }
               },
               required: %w[id delivery_year nomination_type category]

        let(:id) { movie_award.id }
        let(:params) { attributes_for :movie_award, category_id: category.id }

        include_context 'with integration test'
      end

      response '401', 'You are not authorized.' do
        let(:'access-token') { 'invalid' }
        let(:client) { 'invalid' }
        let(:uid) { 'invalid' }

        let(:id) { create(:movie).id }
        let(:params) { attributes_for :movie_award, category_id: category.id }

        include_context 'with integration test'
      end

      response '404', 'Movie award not found.' do
        let(:id) { -1 }
        let(:params) { {} }

        include_context 'with integration test'
      end
    end

    delete 'Delete movie.' do
      tags 'MovieAwards'
      consumes 'application/json'
      parameter name: 'access-token', in: :header, type: :string, required: true
      parameter name: 'client', in: :header, type: :string, required: true
      parameter name: 'uid', in: :header, type: :string, required: true
      parameter name: :id, in: :path, type: :string, required: true
      parameter name: :movie_id, in: :path, type: :string, required: true
      produces 'application/json'

      response '204', 'Movie award deleted successfully.' do
        let(:id) { movie_award.id }

        run_test!
      end

      response '401', 'You are not authorized.' do
        let(:'access-token') { 'invalid' }
        let(:client) { 'invalid' }
        let(:uid) { 'invalid' }

        let(:id) { movie_award.id }

        run_test!
      end

      response '404', 'Movie award not found.' do
        let(:id) { -1 }

        run_test!
      end
    end
  end
end
