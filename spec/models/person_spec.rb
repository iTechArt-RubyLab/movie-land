# == Schema Information
#
# Table name: people
#
#  id         :bigint           not null, primary key
#  birthday   :date
#  deathday   :date
#  married    :boolean
#  name       :string
#  surname    :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  country_id :bigint           not null
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

  context 'with associations' do
    it { should belong_to(:country) }
    it { should have_many(:comments) }
  end
end
