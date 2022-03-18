require 'rails_helper'

RSpec.describe '/comments', type: :request do
  include_context 'with unique cleaner'

  let(:valid_attributes) do
    attributes_for :comment
  end

  let(:invalid_attributes) do
    attributes_for :comment, :invalid_short_body
  end

  let(:admin) { create :user, :admin }

  let(:valid_headers) { sign_in admin }

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new movie Comment' do
        movie = create(:movie)
        expect do
          post api_v1_movie_comments_url(movie_id: movie.id),
               params: { comment: valid_attributes }, headers: valid_headers, as: :json
        end.to change(Comment, :count).by(1)
      end

      it 'creates a new person Comment' do
        person = create(:person)
        expect do
          post api_v1_person_comments_url(person_id: person.id),
               params: { comment: valid_attributes }, headers: valid_headers, as: :json
        end.to change(Comment, :count).by(1)
      end

      it 'creates a new nested Comment' do
        comment = create(:comment)
        expect do
          post api_v1_comment_comments_url(comment_id: comment.id),
               params: { comment: valid_attributes }, headers: valid_headers, as: :json
        end.to change(Comment, :count).by(1)
      end
    end
  end

  describe 'PATCH /update' do
    context 'with valid parameters' do
      let(:new_movie_attributes) do
        attributes_for :comment
      end

      let(:new_person_attributes) do
        attributes_for :comment, :for_person
      end

      let(:new_comment_attributes) do
        attributes_for :comment, :for_comment
      end

      it 'updates the movie requested comment' do
        movie_comment = create(:comment)
        patch api_v1_movie_comment_url(movie_id: movie_comment.commentable_id, id: movie_comment.id),
              params: { comment: new_movie_attributes }, headers: valid_headers, as: :json
        movie_comment.reload
        attributes_for :comment
      end

      it 'updates the person requested comment' do
        person_comment = create(:comment, :for_person)
        patch api_v1_person_comment_url(person_id: person_comment.commentable_id, id: person_comment.id),
              params: { comment: new_person_attributes }, headers: valid_headers, as: :json
        person_comment.reload
        attributes_for :comment, :for_person
      end

      it 'updates the comment requested comment' do
        nested_comment = create(:comment, :for_comment)
        patch api_v1_comment_comment_url(comment_id: nested_comment.commentable_id, id: nested_comment.id),
              params: { comment: new_comment_attributes }, headers: valid_headers, as: :json
        nested_comment.reload
        attributes_for :comment, :for_comment
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the movie requested comment' do
      movie_comment = create(:comment)
      expect do
        delete api_v1_movie_comment_url(id: movie_comment.id, movie_id: movie_comment.commentable_id),
               headers: valid_headers, as: :json
      end.to change(Comment, :count).by(-1)
    end

    it 'destroys the person requested comment' do
      person_comment = create(:comment, :for_person)
      expect do
        delete api_v1_person_comment_url(id: person_comment.id, person_id: person_comment.commentable_id),
               headers: valid_headers, as: :json
      end.to change(Comment, :count).by(-1)
    end

    it 'destroys the comment requested comment' do
      nested_comment = create(:comment, :for_comment)
      expect do
        delete api_v1_comment_comment_url(id: nested_comment.id, comment_id: nested_comment.commentable_id),
               headers: valid_headers, as: :json
      end.to change(Comment, :count).by(-1)
    end
  end
end
