require 'swagger_helper'

RSpec.describe 'api/v1/people', type: :request do
  let(:user) { create :user, :admin }
  let(:valid_headers) { sign_in user }

  let(:'access-token') { valid_headers['access-token'] }
  let(:client) { valid_headers['client'] }
  let(:uid) { valid_headers['uid'] }
  let!(:country) { create :country }

  path '/api/v1/people' do
    get 'Retrieves all people.' do
      tags 'People'
      produces 'application/json'

      response '200', 'people found.' do
        let(:person) { create :person }

        include_context 'with integration test'
      end
    end

    post 'Create a person.' do
      tags 'People'
      consumes 'application/json'
      parameter name: 'access-token', in: :header, type: :string, required: true
      parameter name: 'client', in: :header, type: :string, required: true
      parameter name: 'uid', in: :header, type: :string, required: true
      parameter name: :params, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          surname: { type: :string },
          birthday: { type: :date },
          deathday: { type: :date },
          country_id: { type: :integer },
          married: { type: :boolean }
        },
        required: %w[name surname birthday deathday country_id married]
      }
      produces 'application/json'

      response '201', 'Person created.' do
        let(:params) { attributes_for :person, country_id: country.id }

        include_context 'with integration test'
      end

      response '401', 'You are not authorized.' do
        let(:'access-token') { 'invalid' }
        let(:client) { 'invalid' }
        let(:uid) { 'invalid' }

        let(:params) { attributes_for :person, country_id: country.id }

        include_context 'with integration test'
      end

      response '422', 'Person creation failed.' do
        let(:params) { { person: { name: 'invalid' } } }

        include_context 'with integration test'
      end
    end
  end

  path '/api/v1/people/{id}' do
    get 'Retrieves a person.' do
      tags 'People'
      produces 'application/json'
      parameter name: :id, in: :path, type: :string

      response '200', 'Person found.' do
        let(:id) { create(:person).id }

        include_context 'with integration test'
      end

      response '404', 'Person not found.' do
        let(:id) { -1 }

        include_context 'with integration test'
      end
    end

    put 'Update person.' do
      tags 'People'
      consumes 'application/json'
      parameter name: 'access-token', in: :header, type: :string, required: true
      parameter name: 'client', in: :header, type: :string, required: true
      parameter name: 'uid', in: :header, type: :string, required: true
      parameter name: :id, in: :path, type: :string, required: true
      parameter name: :params, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          surname: { type: :string },
          birthday: { type: :date },
          deathday: { type: :date },
          country_id: { type: :integer },
          married: { type: :boolean }
        },
        required: %w[name surname birthday deathday country_id married]
      }
      produces 'application/json'

      response '200', 'Person updated.' do
        schema type: :object,
               properties: {
                 id: { type: :integer },
                 name: { type: :string },
                 surname: { type: :string },
                 birthday: { type: :date },
                 deathday: { type: :date },
                 country: { type: :hash },
                 married: { type: :boolean }
               },
               required: %w[id name surname birthday deathday country married]

        let(:id) { create(:person).id }
        let(:params) { attributes_for :person, country_id: country.id }

        include_context 'with integration test'
      end

      response '401', 'You are not authorized.' do
        let(:'access-token') { 'invalid' }
        let(:client) { 'invalid' }
        let(:uid) { 'invalid' }

        let(:id) { create(:person).id }
        let(:params) { attributes_for :person, country_id: country.id }

        include_context 'with integration test'
      end

      response '404', 'Person not found.' do
        let(:id) { -1 }
        let(:params) { {} }

        include_context 'with integration test'
      end
    end

    delete 'Delete person.' do
      tags 'People'
      consumes 'application/json'
      parameter name: 'access-token', in: :header, type: :string, required: true
      parameter name: 'client', in: :header, type: :string, required: true
      parameter name: 'uid', in: :header, type: :string, required: true
      parameter name: :id, in: :path, type: :string, required: true
      produces 'application/json'

      response '204', 'Person deleted successfully.' do
        let(:id) { create(:person).id }

        run_test!
      end

      response '401', 'You are not authorized.' do
        let(:'access-token') { 'invalid' }
        let(:client) { 'invalid' }
        let(:uid) { 'invalid' }

        let(:id) { create(:person).id }

        run_test!
      end

      response '404', 'Person not found.' do
        let(:id) { -1 }

        run_test!
      end
    end
  end
end
