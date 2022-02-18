require 'rails_helper'

RSpec.describe Season, type: :model do
  context 'with valid attributes' do
    subject(:season) { create :season }

    include_examples 'valid model'
  end

  describe '#title' do
    context 'when too long' do
      subject(:invalid_long_title) { build :season, :invalid_long_title }

      include_examples 'invalid model'
    end

    context 'when too short' do
      subject(:invalid_short_title) { build :season, :invalid_short_title }

      include_examples 'invalid model'
    end
  end

  describe '#number' do
    context 'when too big' do
      subject(:invalid_big_number) { build :season, :invalid_big_number }

      include_examples 'invalid model'
    end

    context 'when too small' do
      subject(:invalid_small_number) { build :season, :invalid_small_number }

      include_examples 'invalid model'
    end

    context 'when decimal' do
      subject(:invalid_decimal_number) { build :season, :invalid_decimal_number }

      include_examples 'invalid model'
    end
  end

  describe '#description' do
    context 'when too long' do
      subject(:invalid_long_description) { build :season, :invalid_long_description }

      include_examples 'invalid model'
    end

    context 'when too short' do
      subject(:invalid_short_description) { build :season, :invalid_short_description }

      include_examples 'invalid model'
    end
  end

  describe '#trailer' do
    context 'when too long' do
      subject(:invalid_trailer_url) { build :season, :invalid_trailer_url }

      include_examples 'invalid model'
    end
  end
end
