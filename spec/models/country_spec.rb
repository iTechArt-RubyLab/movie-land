require 'rails_helper'

RSpec.describe Country, type: :model do
  subject(:country) { create :country }

  context 'with valid attributes' do
    it { expect(country).to be_valid }
  end

  describe '#title' do
    context 'when title is short' do
      subject(:invalid_short_title) { build :country, :invalid_short_title }

      it { expect(invalid_short_title).not_to be_valid }
    end

    context 'when title is long' do
      subject(:invalid_long_title) { build :country, :invalid_long_title }

      it { expect(invalid_long_title).not_to be_valid }
    end
  end
end
