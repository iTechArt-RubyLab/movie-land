require 'swagger_helper'

RSpec.describe 'api/v1/movie-reports', type: :request do
  let(:user) { create :user, :admin }
  let(:valid_headers) { sign_in user }

  let(:'access-token') { valid_headers['access-token'] }
  let(:client) { valid_headers['client'] }
  let(:uid) { valid_headers['uid'] }
  let(:movie_id) { create(:movie).id }

  path '/api/v1/movie-reports' do
    get 'Retrieves csv report from all movies.' do
      tags 'MovieReports'
      produces 'text/csv'
      parameter name: 'access-token', in: :header, type: :string, required: true
      parameter name: 'client', in: :header, type: :string, required: true
      parameter name: 'uid', in: :header, type: :string, required: true

      response '200', 'Movies csv upload successfully.' do
        let(:movies) { create_list(:movie, 5) }

        run_test!
      end
    end
  end

  path '/api/v1/movies/{movie_id}/movie-report' do
    get 'Retrieves csv uploader from a movie.' do
      tags 'MovieReports'
      produces 'text/csv'
      parameter name: 'access-token', in: :header, type: :string, required: true
      parameter name: 'client', in: :header, type: :string, required: true
      parameter name: 'uid', in: :header, type: :string, required: true
      parameter name: :movie_id, in: :path, type: :string, required: true

      response '200', 'Movis csv upload successfully' do
        let(:movie) { create :movie }

        run_test!
      end

      response '404', 'Movie not found.' do
        let(:movie) { create :movie }
        let(:movie_id) { -1 }

        run_test!
      end
    end
  end
end
