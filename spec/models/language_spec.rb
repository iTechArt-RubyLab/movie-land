require 'rails_helper'

RSpec.describe Language, type: :model do
  subject(:language) { create :language }

  context 'with valid data' do
    it { expect(language).to be_valid }
  end
  describe '#name' do
    context 'when name short' do
      subject(:invalid_short_name) { build :language, :invalid_short_name }
      it { expect(invalid_short_name).not_to be_valid }
    end

    context 'when name long' do
      subject(:invalid_long_name) { build :language, :invalid_long_name }
      it { expect(invalid_long_name).not_to be_valid }
    end
  end
end
