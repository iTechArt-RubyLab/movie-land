require 'swagger_helper'

RSpec.describe 'api/v1/categories', type: :request do
  let(:user) { create :user, :admin }
  let(:valid_headers) { sign_in user }

  let(:'access-token') { valid_headers['access-token'] }
  let(:client) { valid_headers['client'] }
  let(:uid) { valid_headers['uid'] }
  let(:award_id) { create(:award).id }
  let!(:category) { create(:category) }

  path '/api/v1/awards/{award_id}/categories' do
    get 'Retrieves all categories.' do
      tags 'AwardCategories'
      produces 'application/json'
      parameter name: 'access-token', in: :header, type: :string, required: true
      parameter name: 'client', in: :header, type: :string, required: true
      parameter name: 'uid', in: :header, type: :string, required: true
      parameter name: :award_id, in: :path, type: :string, required: true

      response '200', 'Categories found.' do
        let(:category) { create :category }

        include_context 'with integration test'
      end

      response '401', 'You are not authorized.' do
        let(:'access-token') { 'invalid' }
        let(:client) { 'invalid' }
        let(:uid) { 'invalid' }

        let(:category) { create :category }

        include_context 'with integration test'
      end
    end

    post 'Create a category on award.' do
      tags 'AwardCategories'
      consumes 'application/json'
      parameter name: 'access-token', in: :header, type: :string, required: true
      parameter name: 'client', in: :header, type: :string, required: true
      parameter name: 'uid', in: :header, type: :string, required: true
      parameter name: :award_id, in: :path, type: :string, required: true
      parameter name: :params, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          award_id: { type: :integer }
        },
        required: %w[name award_id]
      }
      produces 'application/json'

      response '201', 'Category created.' do
        let(:params) { attributes_for :category }

        include_context 'with integration test'
      end

      response '401', 'You are not authorized.' do
        let(:'access-token') { 'invalid' }
        let(:client) { 'invalid' }
        let(:uid) { 'invalid' }

        let(:params) { attributes_for :category }

        include_context 'with integration test'
      end

      response '422', 'Category creation failed validation.' do
        let(:params) { { category: { name: 0 } } }

        include_context 'with integration test'
      end
    end
  end

  path '/api/v1/awards/{award_id}/categories/{id}' do
    put 'Update category.' do
      tags 'AwardCategories'
      consumes 'application/json'
      parameter name: 'access-token', in: :header, type: :string, required: true
      parameter name: 'client', in: :header, type: :string, required: true
      parameter name: 'uid', in: :header, type: :string, required: true
      parameter name: :award_id, in: :path, type: :string, required: true
      parameter name: :id, in: :path, type: :string, required: true
      parameter name: :params, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          award_id: { type: :integer }
        },
        required: %w[name award_id]
      }
      produces 'application/json'

      response '200', 'Category updated.' do
        schema type: :object,
               properties: {
                 id: { type: :integer },
                 name: { type: :string },
                 award: { type: :hash }
               },
               required: %w[id name award]

        let(:award_id) { category.award_id }
        let(:id) { category.id }
        let(:params) { attributes_for :category }

        include_context 'with integration test'
      end

      response '401', 'You are not authorized.' do
        let(:'access-token') { 'invalid' }
        let(:client) { 'invalid' }
        let(:uid) { 'invalid' }

        let(:award_id) { category.award_id }
        let(:id) { category.id }
        let(:params) { attributes_for :category }

        include_context 'with integration test'
      end

      response '404', 'Category not found.' do
        let(:id) { -1 }
        let(:params) { {} }

        include_context 'with integration test'
      end
    end

    delete 'Delete category.' do
      tags 'AwardCategories'
      consumes 'application/json'
      parameter name: 'access-token', in: :header, type: :string, required: true
      parameter name: 'client', in: :header, type: :string, required: true
      parameter name: 'uid', in: :header, type: :string, required: true
      parameter name: :award_id, in: :path, type: :string, required: true
      parameter name: :id, in: :path, type: :string, required: true
      produces 'application/json'

      response '204', 'Category deleted successfully.' do
        let(:award_id) { category.award_id }
        let(:id) { category.id }

        run_test!
      end

      response '401', 'You are not authorized.' do
        let(:'access-token') { 'invalid' }
        let(:client) { 'invalid' }
        let(:uid) { 'invalid' }

        let(:award_id) { category.award_id }
        let(:id) { category.id }

        run_test!
      end

      response '404', 'Category not found.' do
        let(:award_id) { category.award_id }
        let(:id) { -1 }

        run_test!
      end
    end
  end
end
