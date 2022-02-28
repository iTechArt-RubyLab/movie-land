require 'rails_helper'

module Api
  module V1
    RSpec.describe '/tags', type: :request do
      let(:valid_attributes) do
        attributes_for :tag
      end

      let(:invalid_attributes) do
        attributes_for :tag, :invalid_short_name
      end

      let(:valid_headers) do
        { 'ACCEPT' => 'application/json' }
      end

      describe 'GET /index' do
        it 'renders a successful response' do
          Tag.create! valid_attributes
          get api_v1_tags_url, headers: valid_headers, as: :json
          expect(response).to be_successful
        end
      end
    end
  end
end
