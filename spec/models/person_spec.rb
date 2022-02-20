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
end
