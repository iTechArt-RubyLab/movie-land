require 'rails_helper'

module Api
  module V1
    RSpec.describe '/conutries', type: :request do
      let(:valid_attributes) do
        attributes_for :country
      end

      let(:invalid_attributes) do
        attributes_for :country, :invalid_short_name
      end

      let(:valid_headers) do
        { 'ACCEPT' => 'application/json' }
      end

      describe 'GET /index' do
        it 'renders a successful response' do
          Country.create! valid_attributes
          get api_v1_countries_url, headers: valid_headers, as: :json
          expect(response).to be_successful
        end
      end

      describe 'POST /create' do
        context 'with valid parameters' do
          it 'creates a new Country' do
            expect do
              post api_v1_countries_url,
                   params: { country: valid_attributes }, headers: valid_headers, as: :json
            end.to change(Country, :count).by(1)
          end
        end

        context 'with invalid parameters' do
          it 'does not create a new Country' do
            expect do
              post api_v1_countries_url,
                   params: { country: invalid_attributes }, as: :json
            end.to change(Country, :count).by(0)
          end
        end
      end

      describe 'PATCH /update' do
        context 'with valid parameters' do
          let(:new_attributes) do
            attributes_for :country
          end

          it 'updates the requested country' do
            country = Country.create! valid_attributes
            patch api_v1_country_url(country),
                  params: { country: new_attributes }, headers: valid_headers, as: :json
            country.reload
            attributes_for :country
          end
        end
      end

      describe 'DELETE /destroy' do
        it 'destroys the requested country' do
          country = Country.create! valid_attributes
          expect do
            delete api_v1_country_url(country), headers: valid_headers, as: :json
          end.to change(Country, :count).by(-1)
        end
      end
    end
  end
end
