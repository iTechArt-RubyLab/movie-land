require 'rails_helper'

RSpec.describe '/my-ratings', type: :request do
  let!(:user) { create :user, :reviewer }
  let(:valid_headers) { sign_in user }

  let!(:movie) { create :movie }
  let(:valid_attributes) do
    attributes_for :rating, movie_id: movie.id, user_id: user.id
  end

  let(:invalid_attributes) do
    attributes_for :rating, :invalid_small_rating
  end

  describe 'GET /index' do
    it 'renders a successful response' do
      Rating.create! valid_attributes
      get api_v1_my_ratings_url, headers: valid_headers, as: :json
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new Rating with current_user' do
        expect do
          post api_v1_my_ratings_url,
               params: { rating: valid_attributes }, headers: valid_headers, as: :json
        end.to change(Rating, :count).by(1)
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Rating with current_user' do
        expect do
          post api_v1_my_ratings_url,
               params: { rating: invalid_attributes }, as: :json
        end.to change(Rating, :count).by(0)
      end
    end
  end

  describe 'PATCH /update' do
    context 'with valid parameters' do
      let(:new_attributes) do
        attributes_for :rating
      end

      it 'updates the requested rating' do
        rating = Rating.create! valid_attributes
        patch api_v1_my_rating_url(rating),
              params: { rating: new_attributes }, headers: valid_headers, as: :json
        rating.reload
        attributes_for :rating
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested rating' do
      rating = Rating.create! valid_attributes
      expect do
        delete api_v1_my_rating_url(rating), headers: valid_headers, as: :json
      end.to change(Rating, :count).by(-1)
    end
  end
end
