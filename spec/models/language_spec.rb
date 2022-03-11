# == Schema Information
#
# Table name: languages
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_languages_on_name  (name) UNIQUE
#
require 'rails_helper'

RSpec.describe Language, type: :model do
  context 'with valid attributes' do
    subject(:language) { create :language }

    include_examples 'valid model'
  end

  context 'with invalid attributes' do
    context 'when name too short' do
      subject(:invalid_short_name) { build :language, :invalid_short_name }

      include_examples 'invalid model'
    end

    context 'when name too long' do
      subject(:invalid_long_name) { build :language, :invalid_long_name }

      include_examples 'invalid model'
    end
  end

  context 'with validations' do
    it { is_expected.to validate_uniqueness_of(:name).with_message('This language already exists') }
  end

  context 'with associations' do
    it { is_expected.to have_many(:languages_movies) }
    it { is_expected.to have_many(:movies) }
  end
end
