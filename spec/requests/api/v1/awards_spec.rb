require 'rails_helper'

RSpec.describe '/awards', type: :request do
  let(:admin) { create :user, :admin }
  let(:valid_headers) { sign_in admin }
  let!(:country) { create :country }

  let(:valid_attributes) do
    attributes_for :award, country_id: country.id
  end

  let(:invalid_attributes) do
    attributes_for :award, :invalid_short_name
  end

  describe 'GET /index' do
    it 'renders a successful response' do
      Award.create! valid_attributes
      get api_v1_awards_url, headers: valid_headers, as: :json
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new Award' do
        expect do
          post api_v1_awards_url,
               params: { award: valid_attributes }, headers: valid_headers, as: :json
        end.to change(Award, :count).by(1)
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Award' do
        expect do
          post api_v1_awards_url,
               params: { award: invalid_attributes }, as: :json
        end.to change(Award, :count).by(0)
      end
    end
  end

  describe 'PATCH /update' do
    context 'with valid parameters' do
      let(:new_attributes) do
        attributes_for :award
      end

      it 'updates the requested award' do
        award = Award.create! valid_attributes
        patch api_v1_award_url(award),
              params: { award: new_attributes }, headers: valid_headers, as: :json
        award.reload
        attributes_for :award
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested award' do
      award = Award.create! valid_attributes
      expect do
        delete api_v1_award_url(award), headers: valid_headers, as: :json
      end.to change(Award, :count).by(-1)
    end
  end
end
