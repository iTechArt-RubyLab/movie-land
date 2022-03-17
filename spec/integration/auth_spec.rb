require 'swagger_helper'

RSpec.describe 'auth', type: :request do
  let!(:user) { create :user }
  let(:valid_headers) { sign_in user }

  let(:'access-token') { valid_headers['access-token'] }
  let(:client) { valid_headers['client'] }
  let(:uid) { valid_headers['uid'] }

  path '/auth' do
    post 'Sign up.' do
      tags 'Auth'
      consumes 'application/json'
      parameter name: :params, in: :body, schema: {
        type: :object,
        properties: {
          email: { type: :string },
          password: { type: :string },
          password_confirmation: { type: :string },
          name: { type: :string },
          surname: { type: :string },
          username: { type: :string },
          birthday: { type: :date },
          role_id: { type: :integer }
        },
        required: %w[email password password_confirmation name surname username birthday role_id]
      }
      produces 'application/json'

      response '200', 'Registration successfully.' do
        let(:params) { attributes_for :user }

        include_context 'with integration test'
      end

      response '422', 'Registration failed.' do
        let(:params) { {} }

        include_context 'with integration test'
      end
    end
  end

  path '/auth/sign_in' do
    post 'Sign in.' do
      tags 'Auth'
      consumes 'application/json'
      parameter name: :params, in: :body, schema: {
        type: :object,
        properties: {
          email: { type: :string },
          password: { type: :string }
        },
        required: %w[email password]
      }
      produces 'application/json'

      response '200', 'Login successfully.' do
        let(:params) { { email: user.email, password: user.password } }

        include_context 'with integration test'
      end

      response '401', 'Login failed.' do
        let(:params) { {} }

        include_context 'with integration test'
      end
    end
  end

  path '/auth/sign_out' do
    delete 'Sign out.' do
      tags 'Auth'
      consumes 'application/json'
      parameter name: 'access-token', in: :header, type: :string, required: true
      parameter name: 'client', in: :header, type: :string, required: true
      parameter name: 'uid', in: :header, type: :string, required: true
      parameter name: :params, in: :body, schema: {
        type: :object,
        properties: {
          email: { type: :string },
          password: { type: :string }
        },
        required: %w[email password]
      }
      produces 'application/json'

      response '200', 'Logout successfully.' do
        let(:params) { { email: user.email, password: user.password } }

        include_context 'with integration test'
      end

      response '404', 'Logout failed.' do
        let(:'access-token') { 'invalid' }
        let(:client) { 'invalid' }
        let(:uid) { 'invalid' }

        let(:params) { {} }

        include_context 'with integration test'
      end
    end
  end
end
