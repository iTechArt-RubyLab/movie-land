require 'swagger_helper'

RSpec.describe 'api/v1/permissions', type: :request do
  let(:user) { create :user, :admin }
  let(:valid_headers) { sign_in user }

  let(:'access-token') { valid_headers['access-token'] }
  let(:client) { valid_headers['client'] }
  let(:uid) { valid_headers['uid'] }
  let(:role_id) { permission.role.id }
  let!(:permission) { create :permission, :admin }

  path '/api/v1/roles/{role_id}/permissions' do
    get 'Retrieves a role.' do
      tags 'RolePermissions'
      produces 'application/json'
      parameter name: 'access-token', in: :header, type: :string, required: true
      parameter name: 'client', in: :header, type: :string, required: true
      parameter name: 'uid', in: :header, type: :string, required: true
      parameter name: :role_id, in: :path, type: :string, required: true

      response '200', 'Permission found.' do
        include_context 'with integration test'
      end
    end

    post 'Create a permission on Role.' do
      tags 'RolePermissions'
      consumes 'application/json'
      parameter name: 'access-token', in: :header, type: :string, required: true
      parameter name: 'client', in: :header, type: :string, required: true
      parameter name: 'uid', in: :header, type: :string, required: true
      parameter name: :role_id, in: :path, type: :string, required: true
      parameter name: :params, in: :body, schema: {
        type: :object,
        properties: {
          can_lock_user: { type: :boolean },
          can_edit_role: { type: :boolean },
          can_edit_permission: { type: :boolean },
          can_give_rating: { type: :boolean },
          can_set_role: { type: :boolean },
          can_edit_movie: { type: :boolean },
          can_read_movie: { type: :boolean },
          can_edit_person: { type: :boolean },
          can_read_person: { type: :boolean },
          can_read_entities: { type: :boolean },
          can_edit_entities: { type: :boolean },
          can_read_user: { type: :boolean },
          can_edit_view_list: { type: :boolean },
          can_read_view_list: { type: :boolean },
          can_leave_comment: { type: :boolean },
          can_export_to_csv: { type: :boolean },
          can_read_award: { type: :boolean },
          can_edit_award: { type: :boolean }
        },
        required: %w[can_lock_user can_edit_role can_edit_permission can_give_rating can_set_role
                     can_edit_movie can_read_movie can_edit_person can_read_person can_read_entities
                     can_edit_entities can_read_user can_edit_view_list can_read_view_list
                     can_leave_comment can_export_to_csv can_read_award can_edit_award]
      }
      produces 'application/json'

      response '201', 'Permission created.' do
        let(:params) { attributes_for :permission }

        include_context 'with integration test'
      end

      response '401', 'You are not authorized.' do
        let(:'access-token') { 'invalid' }
        let(:client) { 'invalid' }
        let(:uid) { 'invalid' }

        let(:params) { attributes_for :permission }

        include_context 'with integration test'
      end
    end

    put 'Update permission.' do
      tags 'RolePermissions'
      consumes 'application/json'
      parameter name: 'access-token', in: :header, type: :string, required: true
      parameter name: 'client', in: :header, type: :string, required: true
      parameter name: 'uid', in: :header, type: :string, required: true
      parameter name: :role_id, in: :path, type: :string, required: true
      parameter name: :params, in: :body, schema: {
        type: :object,
        properties: {
          can_lock_user: { type: :boolean },
          can_edit_role: { type: :boolean },
          can_edit_permission: { type: :boolean },
          can_give_rating: { type: :boolean },
          can_set_role: { type: :boolean },
          can_edit_movie: { type: :boolean },
          can_read_movie: { type: :boolean },
          can_edit_person: { type: :boolean },
          can_read_person: { type: :boolean },
          can_read_entities: { type: :boolean },
          can_edit_entities: { type: :boolean },
          can_read_user: { type: :boolean },
          can_edit_view_list: { type: :boolean },
          can_read_view_list: { type: :boolean },
          can_leave_comment: { type: :boolean },
          can_export_to_csv: { type: :boolean },
          can_read_award: { type: :boolean },
          can_edit_award: { type: :boolean }
        },
        required: %w[can_lock_user can_edit_role can_edit_permission can_give_rating can_set_role
                     can_edit_movie can_read_movie can_edit_person can_read_person can_read_entities
                     can_edit_entities can_read_user can_edit_view_list can_read_view_list
                     can_leave_comment can_export_to_csv can_read_award can_edit_award]
      }
      produces 'application/json'

      response '200', 'Permission updated.' do
        let(:params) { attributes_for :permission }

        include_context 'with integration test'
      end

      response '401', 'You are not authorized.' do
        let(:'access-token') { 'invalid' }
        let(:client) { 'invalid' }
        let(:uid) { 'invalid' }

        let(:params) { attributes_for :permission }

        include_context 'with integration test'
      end
    end
  end
end
