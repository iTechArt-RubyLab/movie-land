require 'swagger_helper'

RSpec.describe 'api/v1/awards', type: :request do
  let(:user) { create :user, :admin }
  let(:valid_headers) { sign_in user }

  let(:'access-token') { valid_headers['access-token'] }
  let(:client) { valid_headers['client'] }
  let(:uid) { valid_headers['uid'] }
  let!(:country) { create :country }

  path '/api/v1/awards' do
    get 'Retrieves all awards.' do
      tags 'Awards'
      produces 'application/json'
      parameter name: 'access-token', in: :header, type: :string, required: true
      parameter name: 'client', in: :header, type: :string, required: true
      parameter name: 'uid', in: :header, type: :string, required: true

      response '200', 'Awards found.' do
        let(:award) { create :award }

        include_context 'with integration test'
      end

      response '401', 'You are not authorized.' do
        let(:'access-token') { 'invalid' }
        let(:client) { 'invalid' }
        let(:uid) { 'invalid' }

        let(:award) { create :award }

        include_context 'with integration test'
      end
    end

    post 'Create a award.' do
      tags 'Awards'
      consumes 'application/json'
      parameter name: 'access-token', in: :header, type: :string, required: true
      parameter name: 'client', in: :header, type: :string, required: true
      parameter name: 'uid', in: :header, type: :string, required: true
      parameter name: :params, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          country_id: { type: :integer }
        },
        required: %w[name country_id]
      }
      produces 'application/json'

      response '201', 'Award created.' do
        let(:params) { attributes_for :award, country_id: country.id }

        include_context 'with integration test'
      end

      response '401', 'You are not authorized.' do
        let(:'access-token') { 'invalid' }
        let(:client) { 'invalid' }
        let(:uid) { 'invalid' }

        let(:params) { attributes_for :award }

        include_context 'with integration test'
      end

      response '422', 'Award creation failed validation.' do
        let(:params) { { award: { name: 'invalid' } } }

        include_context 'with integration test'
      end
    end
  end

  path '/api/v1/awards/{id}' do
    get 'Retrieves a award.' do
      tags 'Awards'
      produces 'application/json'
      parameter name: 'access-token', in: :header, type: :string, required: true
      parameter name: 'client', in: :header, type: :string, required: true
      parameter name: 'uid', in: :header, type: :string, required: true
      parameter name: :id, in: :path, type: :string, required: true

      response '200', 'Awards found.' do
        let(:id) { create(:award).id }

        include_context 'with integration test'
      end

      response '401', 'You are not authorized.' do
        let(:'access-token') { 'invalid' }
        let(:client) { 'invalid' }
        let(:uid) { 'invalid' }

        let(:id) { create(:award).id }

        include_context 'with integration test'
      end

      response '404', 'Award not found.' do
        let(:id) { -1 }

        include_context 'with integration test'
      end
    end

    put 'Update award.' do
      tags 'Awards'
      consumes 'application/json'
      parameter name: 'access-token', in: :header, type: :string, required: true
      parameter name: 'client', in: :header, type: :string, required: true
      parameter name: 'uid', in: :header, type: :string, required: true
      parameter name: :id, in: :path, type: :string, required: true
      parameter name: :params, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          country_id: { type: :integer }
        },
        required: %w[name country_id]
      }
      produces 'application/json'

      response '200', 'Award updated.' do
        schema type: :object,
               properties: {
                 id: { type: :integer },
                 name: { type: :string },
                 country: { type: :hash }
               },
               required: %w[id name country]

        let(:id) { create(:award).id }
        let(:params) { attributes_for :award, country_id: country.id }

        include_context 'with integration test'
      end

      response '401', 'You are not authorized.' do
        let(:'access-token') { 'invalid' }
        let(:client) { 'invalid' }
        let(:uid) { 'invalid' }

        let(:id) { create(:award).id }
        let(:params) { attributes_for :award, country_id: country.id }

        include_context 'with integration test'
      end

      response '404', 'Award not found.' do
        let(:id) { -1 }
        let(:params) { {} }

        include_context 'with integration test'
      end
    end

    delete 'Delete award.' do
      tags 'Awards'
      consumes 'application/json'
      parameter name: 'access-token', in: :header, type: :string, required: true
      parameter name: 'client', in: :header, type: :string, required: true
      parameter name: 'uid', in: :header, type: :string, required: true
      parameter name: :id, in: :path, type: :string, required: true
      produces 'application/json'

      response '204', 'Award deleted successfully.' do
        let(:id) { create(:award).id }

        run_test!
      end

      response '401', 'You are not authorized.' do
        let(:'access-token') { 'invalid' }
        let(:client) { 'invalid' }
        let(:uid) { 'invalid' }

        let(:id) { create(:award).id }

        run_test!
      end

      response '404', 'Award not found.' do
        let(:id) { -1 }

        run_test!
      end
    end
  end
end
