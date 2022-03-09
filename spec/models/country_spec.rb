# == Schema Information
#
# Table name: countries
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_countries_on_name  (name) UNIQUE
#
require 'rails_helper'

RSpec.describe Country, type: :model do
  context 'with valid attributes' do
    subject(:country) { create :country }

    include_examples 'valid model'
  end

  context 'with invalid attributes' do
    context 'when name too short' do
      subject(:invalid_short_name) { build :country, :invalid_short_name }

      include_examples 'invalid model'
    end

    context 'when name too long' do
      subject(:invalid_long_name) { build :country, :invalid_long_name }

      include_examples 'invalid model'
    end
  end

  context 'with validations' do
    it { is_expected.to validate_uniqueness_of(:name).with_message('This country already exists') }
  end

  context 'with associations' do
    it { is_expected.to have_many(:countries_movies) }
    it { is_expected.to have_many(:movies) }
    it { is_expected.to have_many(:people) }
  end
end
