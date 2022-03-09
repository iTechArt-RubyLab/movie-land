require 'rails_helper'

RSpec.describe '/genres', type: :request do
  let(:admin) { create :user, :admin }
  let(:valid_headers) { sign_in admin }

  let(:valid_attributes) do
    attributes_for :genre
  end

  let(:invalid_attributes) do
    attributes_for :genre, :invalid_short_name
  end

  describe 'GET /index' do
    it 'renders a successful response' do
      Genre.create! valid_attributes
      get api_v1_genres_url, headers: valid_headers, as: :json
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new Genre' do
        expect do
          post api_v1_genres_url,
               params: { genre: valid_attributes }, headers: valid_headers, as: :json
        end.to change(Genre, :count).by(1)
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Genre' do
        expect do
          post api_v1_genres_url,
               params: { genre: invalid_attributes }, as: :json
        end.to change(Genre, :count).by(0)
      end
    end
  end

  describe 'PATCH /update' do
    context 'with valid parameters' do
      let(:new_attributes) do
        attributes_for :genre
      end

      it 'updates the requested genre' do
        genre = Genre.create! valid_attributes
        patch api_v1_genre_url(genre),
              params: { genre: new_attributes }, headers: valid_headers, as: :json
        genre.reload
        attributes_for :genre
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested genre' do
      genre = Genre.create! valid_attributes
      expect do
        delete api_v1_genre_url(genre), headers: valid_headers, as: :json
      end.to change(Genre, :count).by(-1)
    end
  end
end
