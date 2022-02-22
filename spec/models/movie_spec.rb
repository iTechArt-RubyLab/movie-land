require 'rails_helper'

RSpec.describe Movie, type: :model do
  context 'with valid attributes' do
    subject(:movie) { create :movie }

    include_examples 'valid model'
  end

  context 'with invalid attributes' do
    context 'when name too long' do
      subject(:invalid_long_name) { build :movie, :invalid_long_name }

      include_examples 'invalid model'
    end

    context 'when name too short' do
      subject(:invalid_short_name) { build :movie, :invalid_short_name }

      include_examples 'invalid model'
    end

    context 'when description too long' do
      subject(:invalid_long_description) { build :movie, :invalid_long_description }

      include_examples 'invalid model'
    end

    context 'when description too short' do
      subject(:invalid_short_description) { build :movie, :invalid_short_description }

      include_examples 'invalid model'
    end

    context 'when tagline too long' do
      subject(:invalid_long_tagline) { build :movie, :invalid_long_tagline }

      include_examples 'invalid model'
    end

    context 'when tagline too short' do
      subject(:invalid_short_tagline) { build :movie, :invalid_short_tagline }

      include_examples 'invalid model'
    end

    context 'when invalid trailer url' do
      subject(:invalid_trailer_url) { build :movie, :invalid_trailer_url }

      include_examples 'invalid model'
    end

    context 'when age limit too big' do
      subject(:invalid_big_age_limit) { build :movie, :invalid_big_age_limit }

      include_examples 'invalid model'
    end

    context 'when age limit too small' do
      subject(:invalid_small_age_limit) { build :movie, :invalid_small_age_limit }

      include_examples 'invalid model'
    end

    context 'when age limit decimal' do
      subject(:invalid_decimal_age_limit) { build :movie, :invalid_decimal_age_limit }

      include_examples 'invalid model'
    end

    context 'when budget too small' do
      subject(:invalid_small_budget) { build :movie, :invalid_small_budget }

      include_examples 'invalid model'
    end

    context 'when budget decimal' do
      subject(:invalid_decimal_budget) { build :movie, :invalid_decimal_budget }

      include_examples 'invalid model'
    end

    context 'when duration too small' do
      subject(:invalid_small_duration) { build :movie, :invalid_small_duration }

      include_examples 'invalid model'
    end

    context 'when duration decimal' do
      subject(:invalid_decimal_duration) { build :movie, :invalid_decimal_duration }

      include_examples 'invalid model'
    end
  end

  describe 'validations' do
    it { is_expected.to validate_uniqueness_of(:name).with_message('This movie already exists') }
  end
end
