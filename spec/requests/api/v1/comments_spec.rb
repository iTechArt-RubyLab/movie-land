require 'rails_helper'

RSpec.describe '/comments', type: :request do
  let(:valid_attributes) do
    attributes_for :comment
  end

  let(:invalid_attributes) do
    attributes_for :comment, :invalid_short_body
  end

  let(:valid_headers) do
    { 'ACCEPT' => 'application/json' }
  end

  let(:movie_comment) { create(:comment) }
  let(:person_comment) { create(:comment, :for_person) }
  let(:nested_comment) { create(:comment, :for_comment) }

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new movie Comment' do
        expect do
          post api_v1_movie_comments_url(movie_id: movie_comment.commentable_id),
               params: { comment: valid_attributes }, headers: valid_headers, as: :json
        end.to change(Comment, :count).by(1)
      end

      it 'creates a new person Comment' do
        expect do
          post api_v1_person_comments_url(person_id: person_comment.commentable_id),
               params: { comment: valid_attributes }, headers: valid_headers, as: :json
        end.to change(Comment, :count).by(1)
      end

      it 'creates a new nested Comment' do
        expect do
          post api_v1_comment_comments_url(comment_id: nested_comment.commentable_id),
               params: { comment: valid_attributes }, headers: valid_headers, as: :json
        end.to change(Comment, :count).by(2)
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
        patch api_v1_movie_comment_url(movie_id: movie_comment.commentable_id, id: movie_comment.id),
              params: { comment: new_movie_attributes }, headers: valid_headers, as: :json
        movie_comment.reload
        attributes_for :comment, :for_person
      end

      it 'updates the person requested comment' do
        patch api_v1_person_comment_url(person_id: person_comment.commentable_id, id: person_comment.id),
              params: { comment: new_person_attributes }, headers: valid_headers, as: :json
        person_comment.reload
        attributes_for :comment
      end

      it 'updates the comment requested comment' do
        patch api_v1_comment_comment_url(comment_id: nested_comment.commentable_id, id: nested_comment.id),
              params: { comment: new_comment_attributes }, headers: valid_headers, as: :json
        nested_comment.reload
        attributes_for :comment, :for_comment
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the movie requested comment' do
      expect do
        create(:comment)
        delete api_v1_movie_comment_url(id: movie_comment.id, movie_id: movie_comment.commentable_id),
               headers: valid_headers, as: :json
      end.to change(Comment, :count).by(2)
    end

    it 'destroys the person requested comment' do
      expect do
        create(:comment, :for_person)
        delete api_v1_person_comment_url(id: person_comment.id, person_id: person_comment.commentable_id),
               headers: valid_headers, as: :json
      end.to change(Comment, :count).by(2)
    end

    it 'destroys the comment requested comment' do
      expect do
        create(:comment, :for_comment)
        delete api_v1_comment_comment_url(id: nested_comment.id, comment_id: nested_comment.commentable_id),
               headers: valid_headers, as: :json
      end.to change(Comment, :count).by(4)
    end
  end
end
