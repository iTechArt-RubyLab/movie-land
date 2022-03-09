require 'rails_helper'

RSpec.describe '/movie_awards', type: :request do
  let!(:movie) { create(:movie) }

  let!(:category) { create(:category) }

  let(:valid_attributes) do
    attributes_for :movie_award, movie_id: movie.id, category_id: category.id
  end

  let(:invalid_attributes) do
    attributes_for :movie_award, :invalid_short_name
  end

  let(:valid_headers) do
    { 'ACCEPT' => 'application/json' }
  end

  describe 'GET /index' do
    it 'renders a successful response' do
      create(:movie_award)
      get api_v1_movie_movie_awards_url(movie_id: movie.id), headers: valid_headers, as: :json
      expect(response).to be_successful
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      movie_award = MovieAward.create! valid_attributes
      get api_v1_movie_movie_award_url(movie_id: movie.id, id: movie_award.id), as: :json
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new MovieAward' do
        expect do
          post api_v1_movie_movie_awards_url(movie_id: movie.id),
               params: { movie_award: valid_attributes }, headers: valid_headers, as: :json
        end.to change(MovieAward, :count).by(1)
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new MovieAward' do
        expect do
          post api_v1_movie_movie_awards_url(movie_id: movie.id),
               params: { movie_award: invalid_attributes }, as: :json
        end.to change(MovieAward, :count).by(0)
      end
    end
  end

  describe 'PATCH /update' do
    context 'with valid parameters' do
      let(:new_attributes) do
        attributes_for :movie_award
      end

      it 'updates the requested movie_award' do
        movie_award = MovieAward.create! valid_attributes
        patch api_v1_movie_movie_award_url(movie_id: movie.id, id: movie_award.id),
              params: { movie_award: new_attributes }, headers: valid_headers, as: :json
        movie_award.reload
        attributes_for :movie_award
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested movie_award' do
      movie_award = MovieAward.create! valid_attributes
      expect do
        delete api_v1_movie_movie_award_url(movie_id: movie.id, id: movie_award.id), headers: valid_headers, as: :json
      end.to change(MovieAward, :count).by(-1)
    end
  end
end
