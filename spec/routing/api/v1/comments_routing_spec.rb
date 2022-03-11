require 'rails_helper'

RSpec.describe Api::V1::CommentsController, type: :routing do
  describe 'routing' do
    context 'with movie' do
      it 'routes to #create' do
        expect(post: 'api/v1/movies/1/comments').to route_to('api/v1/comments#create', movie_id: '1')
      end

      it 'routes to #update via PUT' do
        expect(put: 'api/v1/movies/1/comments/1').to route_to('api/v1/comments#update', movie_id: '1', id: '1')
      end

      it 'routes to #update via PATCH' do
        expect(patch: 'api/v1/movies/1/comments/1').to route_to('api/v1/comments#update', movie_id: '1', id: '1')
      end

      it 'routes to #destroy' do
        expect(delete: 'api/v1/movies/1/comments/1').to route_to('api/v1/comments#destroy', movie_id: '1', id: '1')
      end
    end

    context 'with person' do
      it 'routes to #create' do
        expect(post: 'api/v1/people/1/comments').to route_to('api/v1/comments#create', person_id: '1')
      end

      it 'routes to #update via PUT' do
        expect(put: 'api/v1/people/1/comments/1').to route_to('api/v1/comments#update', person_id: '1', id: '1')
      end

      it 'routes to #update via PATCH' do
        expect(patch: 'api/v1/people/1/comments/1').to route_to('api/v1/comments#update', person_id: '1', id: '1')
      end

      it 'routes to #destroy' do
        expect(delete: 'api/v1/people/1/comments/1').to route_to('api/v1/comments#destroy', person_id: '1', id: '1')
      end
    end

    context 'with comment' do
      it 'routes to #create' do
        expect(post: 'api/v1/comments/1/comments').to route_to('api/v1/comments#create', comment_id: '1')
      end

      it 'routes to #update via PUT' do
        expect(put: 'api/v1/comments/1/comments/1').to route_to('api/v1/comments#update', comment_id: '1', id: '1')
      end

      it 'routes to #update via PATCH' do
        expect(patch: 'api/v1/comments/1/comments/1').to route_to('api/v1/comments#update', comment_id: '1', id: '1')
      end

      it 'routes to #destroy' do
        expect(delete: 'api/v1/comments/1/comments/1').to route_to('api/v1/comments#destroy', comment_id: '1',
                                                                                              id: '1')
      end
    end
  end
end
