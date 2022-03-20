require 'rails_helper'

RSpec.describe '/movie_reports', type: :request do
  include_context 'with unique cleaner'

  let(:admin) { create :user, :admin }
  let(:valid_headers) { sign_in admin }

  describe 'GET /index' do
    it 'renders a successful response' do
      create_list(:movie, 3)
      get "#{api_v1_movie_reports_url}.csv", headers: valid_headers, as: :csv
      expect(response).to be_successful
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      movie = create(:movie)
      get "#{api_v1_movie_movie_report_url(movie_id: movie.id)}.csv", headers: valid_headers, as: :csv
      expect(response).to be_successful
    end
  end
end
