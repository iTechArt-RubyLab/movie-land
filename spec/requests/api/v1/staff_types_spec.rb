require 'rails_helper'

module Api
  module V1
    RSpec.describe '/staff_types', type: :request do
      let(:valid_attributes) do
        attributes_for :staff_type
      end

      let(:invalid_attributes) do
        attributes_for :staff_type, :invalid_short_name
      end

      let(:valid_headers) do
        { 'ACCEPT' => 'application/json' }
      end

      describe 'GET /index' do
        it 'renders a successful response' do
          Tag.create! valid_attributes
          get api_v1_staff_types_url, headers: valid_headers, as: :json
          expect(response).to be_successful
        end
      end

      describe 'GET /show' do
        it 'renders a successful response' do
          staff_type = StaffType.create! valid_attributes
          get api_v1_staff_type_url(staff_type), as: :json
          expect(response).to be_successful
        end
      end

      describe 'POST /create' do
        context 'with valid parameters' do
          it 'creates a new StaffType' do
            expect do
              post api_v1_staff_types_url,
                   params: { staff_type: valid_attributes }, headers: valid_headers, as: :json
            end.to change(StaffType, :count).by(1)
          end
        end

        context 'with invalid parameters' do
          it 'does not create a new StaffType' do
            expect do
              post api_v1_staff_types_url,
                   params: { staff_type: invalid_attributes }, as: :json
            end.to change(StaffType, :count).by(0)
          end
        end
      end

      describe 'PATCH /update' do
        context 'with valid parameters' do
          let(:new_attributes) do
            attributes_for :staff_type
          end

          it 'updates the requested person' do
            staff_type = StaffType.create! valid_attributes
            patch api_v1_staff_type_url(staff_type),
                  params: { staff_type: new_attributes }, headers: valid_headers, as: :json
            staff_type.reload
            attributes_for :staff_type
          end
        end
      end

      describe 'DELETE /destroy' do
        it 'destroys the requested person' do
          staff_type = StaffType.create! valid_attributes
          expect do
            delete api_v1_staff_type_url(staff_type), headers: valid_headers, as: :json
          end.to change(StaffType, :count).by(-1)
        end
      end
    end
  end
end
