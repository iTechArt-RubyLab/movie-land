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

    it { expect(person).to be_valid }
  end

  context 'with invalid attributes' do
    context 'when name is short' do
      subject(:invalid_short_name) { build :person, :invalid_short_name }

      it { expect(invalid_short_name).not_to be_valid }
    end

    context 'when name is long' do
      subject(:invalid_long_name) { build :person, :invalid_long_name }

      it { expect(invalid_long_name).not_to be_valid }
    end

    context 'when surname is short' do
      subject(:invalid_short_surname) { build :person, :invalid_short_surname }

      it { expect(invalid_short_surname).not_to be_valid }
    end

    context 'when surname is long' do
      subject(:invalid_long_surname) { build :person, :invalid_long_surname }

      it { expect(invalid_long_surname).not_to be_valid }
    end
  end

  context 'with associations' do
    it { should belong_to(:country) }
  end
end
