require 'rails_helper'

RSpec.describe Genre, type: :model do
  context 'with valid attributes' do
    subject(:genre) { create :genre }

    include_examples 'valid model'
  end

  context 'with invalid attributes' do
    context 'with name too short' do
      subject(:invalid_short_name) { build :genre, :invalid_short_name }

      include_examples 'invalid model'
    end

    context 'with name too long' do
      subject(:invalid_long_name) { build :genre, :invalid_long_name }

      include_examples 'invalid model'
    end
  end

  describe 'validations' do
    it { is_expected.to validate_uniqueness_of(:name).with_message('This genre already exists') }
  end
end
