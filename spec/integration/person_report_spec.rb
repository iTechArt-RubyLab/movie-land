require 'swagger_helper'

RSpec.describe 'api/v1/person-reports', type: :request do
  let(:user) { create :user, :admin }
  let(:valid_headers) { sign_in user }

  let(:'access-token') { valid_headers['access-token'] }
  let(:client) { valid_headers['client'] }
  let(:uid) { valid_headers['uid'] }
  let(:person_id) { create(:person).id }

  path '/api/v1/person-reports' do
    get 'Retrieves csv report from all movies.' do
      tags 'PersonReports'
      produces 'text/csv'
      parameter name: 'access-token', in: :header, type: :string, required: true
      parameter name: 'client', in: :header, type: :string, required: true
      parameter name: 'uid', in: :header, type: :string, required: true

      response '200', 'Movies csv upload successfully.' do
        let(:people) { create_list(:person, 5) }

        run_test!
      end
    end
  end

  path '/api/v1/people/{person_id}/person-report' do
    get 'Retrieves csv uploader from a movie.' do
      tags 'PersonReports'
      produces 'text/csv'
      parameter name: 'access-token', in: :header, type: :string, required: true
      parameter name: 'client', in: :header, type: :string, required: true
      parameter name: 'uid', in: :header, type: :string, required: true
      parameter name: :person_id, in: :path, type: :string, required: true

      response '200', 'Movis csv upload successfully' do
        let(:person) { create :person }

        run_test!
      end

      response '404', 'Movie not found.' do
        let(:person) { create :person }
        let(:person_id) { -1 }

        run_test!
      end
    end
  end
end
