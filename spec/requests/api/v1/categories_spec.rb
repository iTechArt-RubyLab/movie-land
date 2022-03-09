require 'rails_helper'

RSpec.describe '/categories', type: :request do
  let(:valid_attributes) do
    attributes_for :category
  end

  let(:invalid_attributes) do
    attributes_for :category, :invalid_short_name
  end

  let(:valid_headers) do
    { 'ACCEPT' => 'application/json' }
  end

  describe 'GET /index' do
    it 'renders a successful response' do
      create(:category)
      award = create(:award)
      get api_v1_award_categories_url(award_id: award.id), headers: valid_headers, as: :json
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new Category' do
        award = create(:award)
        expect do
          post api_v1_award_categories_url(award_id: award.id),
               params: { category: valid_attributes }, headers: valid_headers, as: :json
        end.to change(Category, :count).by(1)
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Category' do
        award = create(:award)
        expect do
          post api_v1_award_categories_url(award_id: award.id),
               params: { company: invalid_attributes }, as: :json
        end.to change(Category, :count).by(0)
      end
    end
  end

  describe 'PATCH /update' do
    context 'with valid parameters' do
      let(:new_attributes) do
        attributes_for :category
      end

      it 'updates the award requested category' do
        category = create(:category)
        patch api_v1_award_category_url(award_id: category.award_id, id: category.id),
              params: { category: new_attributes }, headers: valid_headers, as: :json
        category.reload
        attributes_for :category
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the award requested category' do
      category = create(:category)
      expect do
        delete api_v1_award_category_url(id: category.id, award_id: category.award_id),
               headers: valid_headers, as: :json
      end.to change(Category, :count).by(-1)
    end
  end
end
