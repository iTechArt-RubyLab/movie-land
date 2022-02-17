require 'rails_helper'

RSpec.describe Category, type: :model do
  subject(:category) { create :category }

  context 'with valid data' do
    it { expect(category).to be_valid }
  end
  describe '#name' do
    context 'when name short' do
      subject(:invalid_short_name) { build :category, :invalid_short_name }
      it { expect(invalid_short_name).not_to be_valid }
    end

    context 'when name long' do
      subject(:invalid_long_name) { build :category, :invalid_long_name }
      it { expect(invalid_long_name).not_to be_valid }
    end
  end
end
