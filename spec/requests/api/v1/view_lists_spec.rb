require 'rails_helper'

RSpec.describe '/my-view-list', type: :request do
  let(:user) { create :user, :reviewer }
  let(:valid_headers) { sign_in user }

  let!(:movie) { create :movie }
  let(:valid_attributes) do
    attributes_for :view_list, :will_watch_status, movie_id: movie.id, user_id: user.id
  end

  let(:invalid_attributes) do
    attributes_for :view_list, :invalid_watching_status
  end

  describe 'GET /index' do
    it 'renders a successful response' do
      ViewList.create! valid_attributes
      get api_v1_my_view_list_index_url, headers: valid_headers, as: :json
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new Rating with current_user' do
        expect do
          post api_v1_my_view_list_index_url,
               params: { view_list: valid_attributes }, headers: valid_headers, as: :json
        end.to change(ViewList, :count).by(1)
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Rating with current_user' do
        expect do
          post api_v1_my_view_list_index_url,
               params: { view_list: invalid_attributes }, as: :json
        end.to change(ViewList, :count).by(0)
      end
    end
  end

  describe 'PATCH /update' do
    context 'with valid parameters' do
      let(:new_attributes) do
        attributes_for :view_list
      end

      it 'updates the requested rating' do
        view_list = ViewList.create! valid_attributes
        patch api_v1_my_view_list_url(view_list),
              params: { view_list: new_attributes }, headers: valid_headers, as: :json
        view_list.reload
        attributes_for :view_list
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested rating' do
      view_list = ViewList.create! valid_attributes
      expect do
        delete api_v1_my_view_list_url(view_list), headers: valid_headers, as: :json
      end.to change(ViewList, :count).by(-1)
    end
  end
end
