require 'rails_helper'

RSpec.describe Country, type: :model do
  subject(:country) { create :country }

  context 'with valid attributes' do
    it { expect(country).to be_valid }
  end

  describe '#name' do
    context 'when name is short' do
      subject(:invalid_short_name) { build :country, :invalid_short_name }

      it { expect(invalid_short_name).not_to be_valid }
    end

    context 'when name is long' do
      subject(:invalid_long_name) { build :country, :invalid_long_name }

      it { expect(invalid_long_name).not_to be_valid }
    end
  end
end
