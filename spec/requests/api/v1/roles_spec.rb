require 'rails_helper'

RSpec.describe '/roles', type: :request do
  let(:valid_attributes) do
    attributes_for :role
  end

  let(:invalid_attributes) do
    attributes_for :role, :invalid_short_name
  end

  let(:valid_headers) do
    { 'ACCEPT' => 'application/json' }
  end

  describe 'GET /index' do
    it 'renders a successful response' do
      Role.create! valid_attributes
      get api_v1_roles_url, headers: valid_headers, as: :json
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new Role' do
        expect do
          post api_v1_roles_url,
               params: { role: valid_attributes }, headers: valid_headers, as: :json
        end.to change(Role, :count).by(1)
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Role' do
        expect do
          post api_v1_roles_url,
               params: { role: invalid_attributes }, as: :json
        end.to change(Role, :count).by(0)
      end
    end
  end

  describe 'PATCH /update' do
    context 'with valid parameters' do
      let(:new_attributes) do
        attributes_for :role
      end

      it 'updates the requested role' do
        role = Role.create! valid_attributes
        patch api_v1_role_url(role),
              params: { role: new_attributes }, headers: valid_headers, as: :json
        role.reload
        attributes_for :role
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested role' do
      role = Role.create! valid_attributes
      expect do
        delete api_v1_role_url(role), headers: valid_headers, as: :json
      end.to change(Role, :count).by(-1)
    end
  end
end
