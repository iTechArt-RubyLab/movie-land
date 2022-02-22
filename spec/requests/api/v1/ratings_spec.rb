require 'rails_helper'

module Api
  module V1
    RSpec.describe '/ratings', type: :request do
      let!(:user) { create :user }
      let!(:movie) { create :movie }

      let(:valid_attributes) do
        attributes_for :rating, user_id: user.id, movie_id: movie.id
      end

      let(:invalid_attributes) do
        attributes_for :rating, :invalid_short_body
      end

      let(:valid_headers) do
        { 'ACCEPT' => 'application/json' }
      end

      describe 'GET /index' do
        it 'renders a successful response' do
          Rating.create! valid_attributes
          get api_v1_ratings_url, headers: valid_headers, as: :json
          expect(response).to be_successful
        end
      end

      describe 'GET /show' do
        it 'renders a successful response' do
          rating = Rating.create! valid_attributes
          get api_v1_ratings_url(rating), as: :json
          expect(response).to be_successful
        end
      end

      describe 'POST /create' do
        context 'with valid parameters' do
          it 'creates a new Rating' do
            expect do
              post api_v1_ratings_url,
                   params: { rating: valid_attributes }, headers: valid_headers, as: :json
            end.to change(Rating, :count).by(1)
          end
        end

        context 'with invalid parameters' do
          it 'does not create a new Rating' do
            expect do
              post api_v1_ratings_url,
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

          it 'updates the requested person' do
            rating = Rating.create! valid_attributes
            patch api_v1_rating_url(rating),
                  params: { rating: new_attributes }, headers: valid_headers, as: :json
            rating.reload
            attributes_for :rating
          end
        end
      end

      describe 'DELETE /destroy' do
        it 'destroys the requested person' do
          rating = Rating.create! valid_attributes
          expect do
            delete api_v1_rating_url(rating), headers: valid_headers, as: :json
          end.to change(Rating, :count).by(-1)
        end
      end
    end
  end
end
