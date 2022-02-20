require 'rails_helper'

module Api
  module V1
    RSpec.describe '/people', type: :request do
      let!(:country) { create :country }
      let(:valid_attributes) do
        attributes_for :person, country_id: country.id
      end

      let(:invalid_attributes) do
        attributes_for :person, :invalid_short_name
      end

      let(:valid_headers) do
        { 'ACCEPT' => 'application/json' }
      end

      describe 'GET /index' do
        it 'renders a successful response' do
          Person.create! valid_attributes
          get api_v1_people_url, headers: valid_headers, as: :json
          expect(response).to be_successful
        end
      end

      describe 'GET /show' do
        it 'renders a successful response' do
          person = Person.create! valid_attributes
          get api_v1_person_url(person), as: :json
          expect(response).to be_successful
        end
      end

      describe 'POST /create' do
        context 'with valid parameters' do
          it 'creates a new Person' do
            expect do
              post api_v1_people_url,
                   params: { person: valid_attributes }, headers: valid_headers, as: :json
            end.to change(Person, :count).by(1)
          end
        end

        context 'with invalid parameters' do
          it 'does not create a new Person' do
            expect do
              post api_v1_people_url,
                   params: { person: invalid_attributes }, as: :json
            end.to change(Person, :count).by(0)
          end
        end
      end

      describe 'PATCH /update' do
        context 'with valid parameters' do
          let(:new_attributes) do
            attributes_for :person
          end

          it 'updates the requested person' do
            person = Person.create! valid_attributes
            patch api_v1_person_url(person),
                  params: { person: new_attributes }, headers: valid_headers, as: :json
            person.reload
            attributes_for :person
          end
        end
      end

      describe 'DELETE /destroy' do
        it 'destroys the requested person' do
          person = Person.create! valid_attributes
          expect do
            delete api_v1_person_url(person), headers: valid_headers, as: :json
          end.to change(Person, :count).by(-1)
        end
      end
    end
  end
end
