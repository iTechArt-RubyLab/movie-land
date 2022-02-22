require 'rails_helper'

module Api
  module V1
    RSpec.describe '/tags', type: :request do
      let(:valid_attributes) do
        attributes_for :tag
      end

      let(:invalid_attributes) do
        attributes_for :tag, :invalid_short_name
      end

      let(:valid_headers) do
        { 'ACCEPT' => 'application/json' }
      end

      describe 'GET /index' do
        it 'renders a successful response' do
          Tag.create! valid_attributes
          get api_v1_tags_url, headers: valid_headers, as: :json
          expect(response).to be_successful
        end
      end

      describe 'GET /show' do
        it 'renders a successful response' do
          tag = Tag.create! valid_attributes
          get api_v1_tag_url(tag), as: :json
          expect(response).to be_successful
        end
      end

      describe 'POST /create' do
        context 'with valid parameters' do
          it 'creates a new Tag' do
            expect do
              post api_v1_tags_url,
                   params: { tag: valid_attributes }, headers: valid_headers, as: :json
            end.to change(Tag, :count).by(1)
          end
        end

        context 'with invalid parameters' do
          it 'does not create a new Tag' do
            expect do
              post api_v1_tags_url,
                   params: { tag: invalid_attributes }, as: :json
            end.to change(Tag, :count).by(0)
          end
        end
      end

      describe 'PATCH /update' do
        context 'with valid parameters' do
          let(:new_attributes) do
            attributes_for :tag
          end

          it 'updates the requested person' do
            tag = Tag.create! valid_attributes
            patch api_v1_tag_url(tag),
                  params: { tag: new_attributes }, headers: valid_headers, as: :json
            tag.reload
            attributes_for :tag
          end
        end
      end

      describe 'DELETE /destroy' do
        it 'destroys the requested person' do
          tag = Tag.create! valid_attributes
          expect do
            delete api_v1_tag_url(tag), headers: valid_headers, as: :json
          end.to change(Tag, :count).by(-1)
        end
      end
    end
  end
end
