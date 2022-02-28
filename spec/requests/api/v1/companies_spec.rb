require 'rails_helper'

module Api
  module V1
    RSpec.describe '/companies', type: :request do
      let(:valid_attributes) do
        attributes_for :company
      end

      let(:invalid_attributes) do
        attributes_for :company, :invalid_short_name
      end

      let(:valid_headers) do
        { 'ACCEPT' => 'application/json' }
      end

      describe 'GET /index' do
        it 'renders a successful response' do
          Company.create! valid_attributes
          get api_v1_companies_url, headers: valid_headers, as: :json
          expect(response).to be_successful
        end
      end

      describe 'POST /create' do
        context 'with valid parameters' do
          it 'creates a new Company' do
            expect do
              post api_v1_companies_url,
                   params: { company: valid_attributes }, headers: valid_headers, as: :json
            end.to change(Company, :count).by(1)
          end
        end

        context 'with invalid parameters' do
          it 'does not create a new Company' do
            expect do
              post api_v1_companies_url,
                   params: { company: invalid_attributes }, as: :json
            end.to change(Company, :count).by(0)
          end
        end
      end

      describe 'PATCH /update' do
        context 'with valid parameters' do
          let(:new_attributes) do
            attributes_for :company
          end

          it 'updates the requested company' do
            company = Company.create! valid_attributes
            patch api_v1_company_url(company),
                  params: { company: new_attributes }, headers: valid_headers, as: :json
            company.reload
            attributes_for :company
          end
        end
      end

      describe 'DELETE /destroy' do
        it 'destroys the requested company' do
          company = Company.create! valid_attributes
          expect do
            delete api_v1_company_url(company), headers: valid_headers, as: :json
          end.to change(Company, :count).by(-1)
        end
      end
    end
  end
end
