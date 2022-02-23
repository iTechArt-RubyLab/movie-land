require 'rails_helper'

RSpec.describe 'Registrations', type: :request do
  let(:user) { create :user }
  let(:valid_attributes) { attributes_for :user }

  describe 'POST /create' do
    it 'creates a new User' do
      expect do
        post '/auth', params: valid_attributes
      end.to change(User, :count).by(1)
    end
  end

  describe 'PUT /update' do
    let(:new_name) { Faker::Name.name }

    it 'updates the name param' do
      put '/auth',
          params: { name: new_name }, headers: user.create_new_auth_token, as: :json
      user.reload
      expect(user.name).to eq(new_name)
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the user' do
      user
      expect do
        delete '/auth', headers: user.create_new_auth_token, as: :json
      end.to change(User, :count).by(-1)
    end
  end
end
