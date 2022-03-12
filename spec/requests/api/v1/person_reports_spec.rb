require 'rails_helper'

RSpec.describe '/person_reports', type: :request do
  let(:admin) { create :user, :admin }
  let(:valid_headers) { sign_in admin }

  describe 'GET /index' do
    it 'renders a successful response' do
      create_list(:person, 3)
      get "#{api_v1_person_reports_url}.csv", headers: valid_headers, as: :csv
      expect(response).to be_successful
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      person = create(:person)
      get "#{api_v1_person_person_report_url(person_id: person.id)}.csv", headers: valid_headers, as: :csv
      expect(response).to be_successful
    end
  end
end
