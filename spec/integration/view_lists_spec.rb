require 'swagger_helper'

RSpec.describe 'api/v1/my-view-list', type: :request do
  let!(:user) { create :user, :reviewer }
  let(:valid_headers) { sign_in user }

  let(:'access-token') { valid_headers['access-token'] }
  let(:client) { valid_headers['client'] }
  let(:uid) { valid_headers['uid'] }
  let!(:movie) { create :movie }

  path '/api/v1/my-view-list' do
    get 'Retrieves my viewlist.' do
      tags 'Viewlist'
      parameter name: 'access-token', in: :header, type: :string
      parameter name: 'client', in: :header, type: :string
      parameter name: 'uid', in: :header, type: :string
      produces 'application/json'

      response '200', 'My viewlist.' do
        let(:view_list) { create :view_list }

        include_context 'with integration test'
      end

      response '401', 'You are not authorized.' do
        let(:'access-token') { 'invalid' }
        let(:client) { 'invalid' }
        let(:uid) { 'invalid' }

        let(:view_list) { create :view_list }

        include_context 'with integration test'
      end
    end

    post 'Create a viewlist item.' do
      tags 'Viewlist'
      consumes 'application/json'
      parameter name: 'access-token', in: :header, type: :string
      parameter name: 'client', in: :header, type: :string
      parameter name: 'uid', in: :header, type: :string
      parameter name: :params, in: :body, schema: {
        type: :object,
        properties: {
          watching_status: { type: :string },
          user_id: { type: :integer },
          movie_id: { type: :integer }
        },
        required: %w[watching_status user_id movie_id]
      }
      produces 'application/json'

      response '201', 'ViewList item created.' do
        let(:params) { attributes_for :view_list, user_id: user.id, movie_id: movie.id }

        include_context 'with integration test'
      end

      response '401', 'You are not authorized.' do
        let(:'access-token') { 'invalid' }
        let(:client) { 'invalid' }
        let(:uid) { 'invalid' }

        let(:params) { attributes_for :view_list, user_id: user.id, movie_id: movie.id }

        include_context 'with integration test'
      end

      response '422', 'ViewList item creation failed.' do
        let(:params) { { view_list: { view_list: 'invalid' } } }

        include_context 'with integration test'
      end
    end
  end

  path '/api/v1/my-view-list/{id}' do
    put 'Update viewlist item.' do
      tags 'Viewlist'
      consumes 'application/json'
      parameter name: 'access-token', in: :header, type: :string
      parameter name: 'client', in: :header, type: :string
      parameter name: 'uid', in: :header, type: :string
      parameter name: :id, in: :path, type: :string
      parameter name: :params, in: :body, schema: {
        type: :object,
        properties: {
          watching_status: { type: :string },
          user_id: { type: :integer },
          movie_id: { type: :integer }
        },
        required: %w[watching_status user_id movie_id]
      }
      produces 'application/json'

      response '200', 'view_list updated.' do
        schema type: :object,
               properties: {
                 id: { type: :integer },
                 watching_status: { type: :string },
                 user: { type: :hash },
                 movie: { type: :hash }
               },
               required: %w[id watching_status user movie]

        let(:id) { create(:view_list).id }
        let(:params) { { view_list: attributes_for(:view_list, user_id: user.id, movie_id: movie.id) } }

        include_context 'with integration test'
      end

      response '401', 'You are not authorized.' do
        let(:'access-token') { 'invalid' }
        let(:client) { 'invalid' }
        let(:uid) { 'invalid' }

        let(:id) { create(:view_list).id }
        let(:params) { { view_list: attributes_for(:view_list, user_id: user.id, movie_id: movie.id) } }

        include_context 'with integration test'
      end

      response '404', 'Viewlist item not found.' do
        let(:id) { -1 }
        let(:params) { {} }

        include_context 'with integration test'
      end
    end

    delete 'Delete view_list.' do
      tags 'Viewlist'
      consumes 'application/json'
      parameter name: 'access-token', in: :header, type: :string
      parameter name: 'client', in: :header, type: :string
      parameter name: 'uid', in: :header, type: :string
      parameter name: :id, in: :path, type: :string
      produces 'application/json'

      response '204', 'Viewlist item deleted successfully.' do
        let(:id) { create(:view_list).id }

        run_test!
      end

      response '401', 'You are not authorized.' do
        let(:'access-token') { 'invalid' }
        let(:client) { 'invalid' }
        let(:uid) { 'invalid' }

        let(:id) { create(:view_list).id }

        run_test!
      end

      response '404', 'Viewlist item not found.' do
        let(:id) { -1 }

        run_test!
      end
    end
  end
end
