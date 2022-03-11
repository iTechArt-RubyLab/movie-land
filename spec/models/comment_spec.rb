# == Schema Information
#
# Table name: comments
#
#  id               :bigint           not null, primary key
#  body             :text
#  commentable_type :string           not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  commentable_id   :bigint           not null
#  user_id          :bigint           not null
#
# Indexes
#
#  index_comments_on_commentable  (commentable_type,commentable_id)
#  index_comments_on_user_id      (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe Comment, type: :model do
  context 'with valid attributes' do
    subject(:comment) { create :comment }

    include_examples 'valid model'
  end

  context 'with invalid attributes' do
    context 'when body too long' do
      subject(:invalid_long_body) { build :comment, :invalid_long_body }

      include_examples 'invalid model'
    end

    context 'when body too short' do
      subject(:invalid_short_body) { build :comment, :invalid_short_body }

      include_examples 'invalid model'
    end
  end

  context 'with associations' do
    it { should belong_to(:user) }
    it { should belong_to(:commentable) }
    it { should have_many(:comments) }
  end
end
