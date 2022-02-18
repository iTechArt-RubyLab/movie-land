require 'rails_helper'

RSpec.describe Series, type: :model do
  context 'with valid attributes' do
    subject(:series) { create :series }

    include_examples 'valid model'
  end

  describe '#title' do
    context 'when too long' do
      subject(:invalid_long_title) { build :series, :invalid_long_title }

      include_examples 'invalid model'
    end

    context 'when too short' do
      subject(:invalid_short_title) { build :series, :invalid_short_title }

      include_examples 'invalid model'
    end
  end

  describe '#description' do
    context 'when too long' do
      subject(:invalid_long_description) { build :series, :invalid_long_description }

      include_examples 'invalid model'
    end

    context 'when too short' do
      subject(:invalid_short_description) { build :series, :invalid_short_description }

      include_examples 'invalid model'
    end
  end

  describe '#trailer' do
    context 'when incorrect url' do
      subject(:invalid_trailer_url) { build :series, :invalid_trailer_url }

      include_examples 'invalid model'
    end
  end
end
