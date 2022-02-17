require 'rails_helper'

RSpec.describe Tag, type: :model do
  subject(:tag) { create :tag }

  context 'with valid data' do
    it { expect(tag).to be_valid }
  end

  describe '#name' do
    context 'when name short' do
      subject(:invalid_short_name) { build :tag, :invalid_short_name }

      it { expect(invalid_short_name).not_to be_valid }
    end

    context 'when name long' do
      subject(:invalid_long_name) { build :tag, :invalid_long_name }

      it { expect(invalid_long_name).not_to be_valid }
    end
  end
end
