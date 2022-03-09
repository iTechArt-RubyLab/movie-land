require 'rails_helper'

RSpec.describe '/permissions', type: :request do
  let(:admin) { create :user, :admin }
  let(:valid_headers) { sign_in admin }

  let(:valid_attributes) do
    attributes_for :permission
  end

  let(:invalid_attributes) do
    attributes_for :permission, :invalid_nil_attributes
  end

  let(:permission) { create(:permission, :admin) }

  describe 'GET /show' do
    it 'renders a successful response' do
      get api_v1_role_permissions_url(role_id: permission.role.id), headers: valid_headers, as: :json
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new Permission' do
        expect do
          post api_v1_role_permissions_url(role_id: permission.role.id),
               params: { permission: valid_attributes }, headers: valid_headers, as: :json
        end.to change(Permission, :count).by(1)
      end
    end
  end

  describe 'PATCH /update' do
    context 'with valid parameters' do
      let(:new_attributes) do
        attributes_for :permission
      end

      it 'updates the requested permission' do
        patch api_v1_role_permissions_url(role_id: permission.role.id),
              params: { permission: new_attributes }, headers: valid_headers, as: :json
        permission.reload
        attributes_for :permission
      end
    end
  end
end
