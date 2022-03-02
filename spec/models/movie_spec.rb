# == Schema Information
#
# Table name: movies
#
#  id           :bigint           not null, primary key
#  age_limit    :integer
#  budget       :bigint
#  description  :text
#  duration     :integer
#  image        :string
#  name         :string
#  poster       :string
#  release_date :date
#  tagline      :string
#  trailer      :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_movies_on_name  (name) UNIQUE
#
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

  context 'with validations' do
    it { should validate_uniqueness_of(:name).with_message('This movie already exists') }
  end

  context 'with associations' do
    it { should have_many(:companies_movies) }
    it { should have_many(:companies) }
    it { should have_many(:countries_movies) }
    it { should have_many(:countries) }
    it { should have_many(:genres_movies) }
    it { should have_many(:genres) }
    it { should have_many(:languages_movies) }
    it { should have_many(:languages) }
    it { should have_many(:movies_tags) }
    it { should have_many(:tags) }
    it { should have_many(:ratings) }
    it { should accept_nested_attributes_for(:movies_tags) }
  end
end
