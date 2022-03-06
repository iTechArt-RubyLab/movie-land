require 'rails_helper'

RSpec.describe '/languages', type: :request do
  let(:admin) { create :user, :admin }
  let(:valid_headers) { sign_in admin }

  let(:valid_attributes) do
    attributes_for :language
  end

  let(:invalid_attributes) do
    attributes_for :language, :invalid_short_name
  end

  describe 'GET /index' do
    it 'renders a successful response' do
      Language.create! valid_attributes
      get api_v1_languages_url, headers: valid_headers, as: :json
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new Language' do
        expect do
          post api_v1_languages_url,
               params: { language: valid_attributes }, headers: valid_headers, as: :json
        end.to change(Language, :count).by(1)
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Language' do
        expect do
          post api_v1_languages_url,
               params: { language: invalid_attributes }, as: :json
        end.to change(Language, :count).by(0)
      end
    end
  end

  describe 'PATCH /update' do
    context 'with valid parameters' do
      let(:new_attributes) do
        attributes_for :language
      end

      it 'updates the requested Language' do
        language = Language.create! valid_attributes
        patch api_v1_language_url(language),
              params: { language: new_attributes }, headers: valid_headers, as: :json
        language.reload
        attributes_for :language
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested language' do
      language = Language.create! valid_attributes
      expect do
        delete api_v1_language_url(language), headers: valid_headers, as: :json
      end.to change(Language, :count).by(-1)
    end
  end
end
