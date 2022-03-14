# == Schema Information
#
# Table name: people
#
#  id         :bigint           not null, primary key
#  biography  :text
#  birthday   :date
#  deathday   :date
#  married    :boolean
#  name       :string
#  surname    :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  country_id :bigint
#
# Indexes
#
#  index_people_on_country_id  (country_id)
#
# Foreign Keys
#
#  fk_rails_...  (country_id => countries.id)
#
require 'rails_helper'

RSpec.describe Person, type: :model do
  context 'with valid attributes' do
    subject(:person) { create :person }

    include_examples 'valid model'
  end

  context 'with invalid attributes' do
    context 'when name too short' do
      subject(:invalid_short_name) { build :person, :invalid_short_name }

      include_examples 'invalid model'
    end

    context 'when name too long' do
      subject(:invalid_long_name) { build :person, :invalid_long_name }

      include_examples 'invalid model'
    end

    context 'when surname too short' do
      subject(:invalid_short_surname) { build :person, :invalid_short_surname }

      include_examples 'invalid model'
    end

    context 'when surname too long' do
      subject(:invalid_long_surname) { build :person, :invalid_long_surname }

      include_examples 'invalid model'
    end
  end

  context 'with indexes' do
    it 'when indexed' do
      create(:person, name: 'John', surname: 'Doe')

      described_class.__elasticsearch__.refresh_index!
      expect(described_class.search('doe').results.total).to eq(1)
    end
  end

  context 'with associations' do
    it { is_expected.to belong_to(:country).optional }
    it { is_expected.to have_many(:comments) }
    it { is_expected.to have_many(:actor_roles).with_foreign_key('actor_id') }
    it { is_expected.to have_many(:movie_staffs).with_foreign_key('staff_id') }
    it { is_expected.to have_many(:movies).through(:movie_staffs) }
    it { is_expected.to have_many(:movie_awards_person) }
    it { is_expected.to have_many(:movie_awards).through(:movie_awards_person) }
  end
end
