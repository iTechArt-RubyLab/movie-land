# == Schema Information
#
# Table name: movies
#
#  id                :bigint           not null, primary key
#  age_limit         :integer
#  budget            :bigint
#  description       :text
#  duration          :integer
#  images            :string           default([]), is an Array
#  name              :string
#  number_of_ratings :integer          default(0)
#  poster            :string
#  release_date      :date
#  tagline           :string
#  total_score       :integer          default(0)
#  trailer           :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
# Indexes
#
#  index_movies_on_name  (name) UNIQUE
#
require 'rails_helper'

RSpec.describe Movie, type: :model do
  subject(:movie) { create :movie }

  include_context 'with unique cleaner'

  context 'with valid attributes' do
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

    context 'when poster format is incorrect' do
      subject(:invalid_poster_format) { build :movie, :invalid_poster_format }

      include_examples 'invalid model'
    end

    context 'when images format is incorrect' do
      subject(:invalid_images_format) { build :movie, :invalid_images_format }

      include_examples 'invalid model'
    end
  end

  context 'with indexes' do
    it 'when indexed' do
      create(:movie, name: 'American History X')

      described_class.__elasticsearch__.refresh_index!
      expect(described_class.search('hist').results.total).to eq(1)
    end
  end

  context 'with average_rating' do
    context 'when attributes valid' do
      subject(:valid_ratings_attributes) { build :movie, :valid_ratings_attributes }

      let(:average_result) { valid_ratings_attributes.total_score / valid_ratings_attributes.number_of_ratings }

      it { expect(valid_ratings_attributes.average_rating).to be(average_result) }
    end

    context 'when attributes are zero' do
      subject(:zero_ratings_attributes) { build :movie, :zero_ratings_attributes }

      it { expect(zero_ratings_attributes.average_rating).to be_zero }
    end
  end

  context 'with staffs' do
    context 'when directors' do
      let(:person) { create :person }

      before do
        MovieStaff.create(movie: movie, staff: person, staff_type: 'director')
      end

      it { expect(movie.directors.first).to eq(person) }
    end

    context 'when editors' do
      let(:person) { create :person }

      before do
        MovieStaff.create(movie: movie, staff: person, staff_type: 'editor')
      end

      it { expect(movie.editors.first).to eq(person) }
    end

    context 'when compositors' do
      let(:person) { create :person }

      before do
        MovieStaff.create(movie: movie, staff: person, staff_type: 'compositor')
      end

      it { expect(movie.compositors.first).to eq(person) }
    end

    context 'when artists' do
      let(:person) { create :person }

      before do
        MovieStaff.create(movie: movie, staff: person, staff_type: 'artist')
      end

      it { expect(movie.artists.first).to eq(person) }
    end

    context 'when producers' do
      let(:person) { create :person }

      before do
        MovieStaff.create(movie: movie, staff: person, staff_type: 'producer')
      end

      it { expect(movie.producers.first).to eq(person) }
    end

    context 'when screencasters' do
      let(:person) { create :person }

      before do
        MovieStaff.create(movie: movie, staff: person, staff_type: 'screencaster')
      end

      it { expect(movie.screencasters.first).to eq(person) }
    end
  end

  context 'with validations' do
    it { is_expected.to validate_uniqueness_of(:name).with_message('This movie already exists') }
  end

  context 'with associations' do
    it { is_expected.to have_many(:companies_movies) }
    it { is_expected.to have_many(:companies) }
    it { is_expected.to have_many(:countries_movies) }
    it { is_expected.to have_many(:countries) }
    it { is_expected.to have_many(:genres_movies) }
    it { is_expected.to have_many(:genres) }
    it { is_expected.to have_many(:languages_movies) }
    it { is_expected.to have_many(:languages) }
    it { is_expected.to have_many(:movies_tags) }
    it { is_expected.to have_many(:tags) }
    it { is_expected.to have_many(:ratings) }
    it { is_expected.to have_many(:comments) }
    it { is_expected.to have_many(:movie_awards) }
    it { is_expected.to accept_nested_attributes_for(:movies_tags) }
  end
end
