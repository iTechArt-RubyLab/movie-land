require 'rails_helper'

RSpec.describe '/movies', type: :request do
  include_context 'with unique cleaner'

  let(:admin) { create :user, :admin }
  let(:valid_headers) { sign_in admin }

  let(:valid_attributes) do
    attributes_for :movie
  end

  let(:invalid_attributes) do
    attributes_for :movie, :invalid_short_name
  end

  describe 'GET /index' do
    it 'renders a successful response' do
      Movie.create! valid_attributes
      get api_v1_movies_url, headers: valid_headers, as: :json
      expect(response).to be_successful
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      movie = Movie.create! valid_attributes
      get api_v1_movie_url(movie), headers: valid_headers, as: :json
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new Movie' do
        expect do
          post api_v1_movies_url,
               params: { movie: valid_attributes }, headers: valid_headers, as: :json
        end.to change(Movie, :count).by(1)
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Movie' do
        expect do
          post api_v1_movies_url,
               params: { movie: invalid_attributes }, as: :json
        end.to change(Movie, :count).by(0)
      end
    end
  end

  describe 'PATCH /update' do
    context 'with valid parameters' do
      let(:new_attributes) do
        attributes_for :movie
      end

      it 'updates the requested movie' do
        movie = Movie.create! valid_attributes
        patch api_v1_movie_url(movie),
              params: { movie: new_attributes }, headers: valid_headers, as: :json
        movie.reload
        attributes_for :movie
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested movie' do
      movie = Movie.create! valid_attributes
      expect do
        delete api_v1_movie_url(movie), headers: valid_headers, as: :json
      end.to change(Movie, :count).by(-1)
    end
  end
end
