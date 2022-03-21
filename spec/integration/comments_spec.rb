require 'swagger_helper'

RSpec.describe 'api/v1/comments', type: :request do
  let(:user) { create :user, :reviewer }
  let(:valid_headers) { sign_in user }

  let(:'access-token') { valid_headers['access-token'] }
  let(:client) { valid_headers['client'] }
  let(:uid) { valid_headers['uid'] }

  let(:movie_id) { comment.commentable_id }
  let(:comment_id) { nested_comment.commentable_id }
  let(:person_id) { comment.commentable_id }

  let!(:comment) { create :comment }
  let!(:nested_comment) { create :comment, :for_comment }
  let!(:person_comment) { create :comment, :for_person }

  path '/api/v1/movies/{movie_id}/comments' do
    post 'Create a comment on movie.' do
      tags 'MovieComments'
      consumes 'application/json'
      parameter name: 'access-token', in: :header, type: :string, required: true
      parameter name: 'client', in: :header, type: :string, required: true
      parameter name: 'uid', in: :header, type: :string, required: true
      parameter name: :movie_id, in: :path, type: :string, required: true
      parameter name: :params, in: :body, schema: {
        type: :object,
        properties: {
          body: { type: :string }
        },
        required: %w[body]
      }
      produces 'application/json'

      response '201', 'Comment created.' do
        let(:params) { attributes_for :comment }

        include_context 'with integration test'
      end

      response '401', 'You are not authorized.' do
        let(:'access-token') { 'invalid' }
        let(:client) { 'invalid' }
        let(:uid) { 'invalid' }

        let(:params) { attributes_for :comment }

        include_context 'with integration test'
      end

      response '422', 'Comment creation failed validation.' do
        let(:params) { { comment: { body: 0 } } }

        include_context 'with integration test'
      end
    end
  end

  path '/api/v1/movies/{movie_id}/comments/{id}' do
    put 'Update comment.' do
      tags 'MovieComments'
      consumes 'application/json'
      parameter name: 'access-token', in: :header, type: :string, required: true
      parameter name: 'client', in: :header, type: :string, required: true
      parameter name: 'uid', in: :header, type: :string, required: true
      parameter name: :movie_id, in: :path, type: :string, required: true
      parameter name: :id, in: :path, type: :string, required: true
      parameter name: :params, in: :body, schema: {
        type: :object,
        properties: {
          body: { type: :string }
        },
        required: %w[body]
      }
      produces 'application/json'

      response '200', 'Comment updated.' do
        schema type: :object,
               properties: {
                 id: { type: :integer },
                 body: { type: :string }
               },
               required: %w[id body]

        let(:id) { comment.id }
        let(:params) { attributes_for :comment }

        include_context 'with integration test'
      end

      response '401', 'You are not authorized.' do
        let(:'access-token') { 'invalid' }
        let(:client) { 'invalid' }
        let(:uid) { 'invalid' }

        let(:id) { comment.id }
        let(:params) { attributes_for :comment }

        include_context 'with integration test'
      end

      response '404', 'Comment not found.' do
        let(:id) { -1 }
        let(:params) { {} }

        include_context 'with integration test'
      end
    end

    delete 'Delete comment.' do
      tags 'MovieComments'
      consumes 'application/json'
      parameter name: 'access-token', in: :header, type: :string, required: true
      parameter name: 'client', in: :header, type: :string, required: true
      parameter name: 'uid', in: :header, type: :string, required: true
      parameter name: :movie_id, in: :path, type: :string, required: true
      parameter name: :id, in: :path, type: :string, required: true
      produces 'application/json'

      response '204', 'Comment deleted successfully.' do
        let(:id) { comment.id }

        run_test!
      end

      response '401', 'You are not authorized.' do
        let(:'access-token') { 'invalid' }
        let(:client) { 'invalid' }
        let(:uid) { 'invalid' }

        let(:id) { comment.id }

        run_test!
      end

      response '404', 'Comment not found.' do
        let(:id) { -1 }

        run_test!
      end
    end
  end

  path '/api/v1/comments/{comment_id}/comments' do
    post 'Create a nested comment.' do
      tags 'NestedComments'
      consumes 'application/json'
      parameter name: 'access-token', in: :header, type: :string, required: true
      parameter name: 'client', in: :header, type: :string, required: true
      parameter name: 'uid', in: :header, type: :string, required: true
      parameter name: :comment_id, in: :path, type: :string, required: true
      parameter name: :params, in: :body, schema: {
        type: :object,
        properties: {
          body: { type: :string }
        },
        required: %w[body]
      }
      produces 'application/json'

      response '201', 'Comment created.' do
        let(:params) { attributes_for :comment, :for_comment }

        include_context 'with integration test'
      end

      response '401', 'You are not authorized.' do
        let(:'access-token') { 'invalid' }
        let(:client) { 'invalid' }
        let(:uid) { 'invalid' }

        let(:params) { attributes_for :comment, :for_comment }

        include_context 'with integration test'
      end

      response '422', 'Comment creation failed validation.' do
        let(:params) { { comment: { name: 0 } } }

        include_context 'with integration test'
      end
    end
  end

  path '/api/v1/comments/{comment_id}/comments/{id}' do
    put 'Update comment.' do
      tags 'NestedComments'
      consumes 'application/json'
      parameter name: 'access-token', in: :header, type: :string, required: true
      parameter name: 'client', in: :header, type: :string, required: true
      parameter name: 'uid', in: :header, type: :string, required: true
      parameter name: :comment_id, in: :path, type: :string, required: true
      parameter name: :id, in: :path, type: :string, required: true
      parameter name: :params, in: :body, schema: {
        type: :object,
        properties: {
          body: { type: :string }
        },
        required: %w[body]
      }
      produces 'application/json'

      response '200', 'Comment updated.' do
        schema type: :object,
               properties: {
                 id: { type: :integer },
                 body: { type: :string }
               },
               required: %w[id body]

        let(:id) { nested_comment.id }
        let(:params) { attributes_for :comment, :for_comment }

        include_context 'with integration test'
      end

      response '401', 'You are not authorized.' do
        let(:'access-token') { 'invalid' }
        let(:client) { 'invalid' }
        let(:uid) { 'invalid' }

        let(:id) { nested_comment.id }
        let(:params) { attributes_for :comment, :for_comment }

        include_context 'with integration test'
      end

      response '404', 'Comment not found.' do
        let(:id) { -1 }
        let(:params) { {} }

        include_context 'with integration test'
      end
    end

    delete 'Delete comment.' do
      tags 'NestedComments'
      consumes 'application/json'
      parameter name: 'access-token', in: :header, type: :string, required: true
      parameter name: 'client', in: :header, type: :string, required: true
      parameter name: 'uid', in: :header, type: :string, required: true
      parameter name: :comment_id, in: :path, type: :string, required: true
      parameter name: :id, in: :path, type: :string, required: true
      produces 'application/json'

      response '204', 'Comment deleted successfully.' do
        let(:id) { nested_comment.id }

        run_test!
      end

      response '401', 'You are not authorized.' do
        let(:'access-token') { 'invalid' }
        let(:client) { 'invalid' }
        let(:uid) { 'invalid' }

        let(:id) { nested_comment.id }

        run_test!
      end

      response '404', 'Comment not found.' do
        let(:id) { -1 }

        run_test!
      end
    end
  end

  path '/api/v1/people/{person_id}/comments' do
    post 'Create a comment on person.' do
      tags 'PersonComments'
      consumes 'application/json'
      parameter name: 'access-token', in: :header, type: :string, required: true
      parameter name: 'client', in: :header, type: :string, required: true
      parameter name: 'uid', in: :header, type: :string, required: true
      parameter name: :person_id, in: :path, type: :string, required: true
      parameter name: :params, in: :body, schema: {
        type: :object,
        properties: {
          body: { type: :string }
        },
        required: %w[body]
      }
      produces 'application/json'

      response '201', 'Comment created.' do
        let(:params) { attributes_for :comment, :for_person }

        include_context 'with integration test'
      end

      response '401', 'You are not authorized.' do
        let(:'access-token') { 'invalid' }
        let(:client) { 'invalid' }
        let(:uid) { 'invalid' }

        let(:params) { attributes_for :comment, :for_person }

        include_context 'with integration test'
      end

      response '422', 'Comment creation failed validation.' do
        let(:params) { { comment: { name: 0 } } }

        include_context 'with integration test'
      end
    end
  end

  path '/api/v1/people/{person_id}/comments/{id}' do
    put 'Update comment.' do
      tags 'PersonComments'
      consumes 'application/json'
      parameter name: 'access-token', in: :header, type: :string, required: true
      parameter name: 'client', in: :header, type: :string, required: true
      parameter name: 'uid', in: :header, type: :string, required: true
      parameter name: :person_id, in: :path, type: :string, required: true
      parameter name: :id, in: :path, type: :string, required: true
      parameter name: :params, in: :body, schema: {
        type: :object,
        properties: {
          body: { type: :string }
        },
        required: %w[body]
      }
      produces 'application/json'

      response '200', 'Comment updated.' do
        schema type: :object,
               properties: {
                 id: { type: :integer },
                 body: { type: :string }
               },
               required: %w[id body]

        let(:id) { person_comment.id }
        let(:params) { attributes_for :comment, :for_person }

        include_context 'with integration test'
      end

      response '401', 'You are not authorized.' do
        let(:'access-token') { 'invalid' }
        let(:client) { 'invalid' }
        let(:uid) { 'invalid' }

        let(:id) { person_comment.id }
        let(:params) { attributes_for :comment, :for_person }

        include_context 'with integration test'
      end

      response '404', 'Comment not found.' do
        let(:id) { -1 }
        let(:params) { {} }

        include_context 'with integration test'
      end
    end

    delete 'Delete comment.' do
      tags 'PersonComments'
      consumes 'application/json'
      parameter name: 'access-token', in: :header, type: :string, required: true
      parameter name: 'client', in: :header, type: :string, required: true
      parameter name: 'uid', in: :header, type: :string, required: true
      parameter name: :person_id, in: :path, type: :string, required: true
      parameter name: :id, in: :path, type: :string, required: true
      produces 'application/json'

      response '204', 'Comment deleted successfully.' do
        let(:id) { person_comment.id }

        run_test!
      end

      response '401', 'You are not authorized.' do
        let(:'access-token') { 'invalid' }
        let(:client) { 'invalid' }
        let(:uid) { 'invalid' }

        let(:id) { person_comment.id }

        run_test!
      end

      response '404', 'Comment not found.' do
        let(:id) { -1 }

        run_test!
      end
    end
  end
end
