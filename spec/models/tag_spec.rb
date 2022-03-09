# == Schema Information
#
# Table name: tags
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_tags_on_name  (name) UNIQUE
#
require 'rails_helper'

RSpec.describe Tag, type: :model do
  context 'with valid attributes' do
    subject(:tag) { create :tag }

    include_examples 'valid model'
  end

  context 'with invalid attributes' do
    context 'when name too short' do
      subject(:invalid_short_name) { build :tag, :invalid_short_name }

      include_examples 'invalid model'
    end

    context 'when name too long' do
      subject(:invalid_long_name) { build :tag, :invalid_long_name }

      include_examples 'invalid model'
    end
  end

  context 'with validations' do
    it { is_expected.to validate_uniqueness_of(:name).with_message('This tag already exists') }
  end

  context 'with associations' do
    it { is_expected.to have_many(:movies_tags) }
    it { is_expected.to have_many(:movies) }
  end
end
