require 'rails_helper'

RSpec.describe Rating, type: :model do
  subject(:rating) { create :rating }

  context 'with valid attributes' do
    it { expect(rating).to be_valid }
  end

  describe '#body' do
    context 'when body is short' do
      subject(:invalid_short_body) { build :rating, :invalid_short_body }

      it { expect(invalid_short_body).not_to be_valid }
    end

    context 'when body is long' do
      subject(:invalid_long_body) { build :rating, :invalid_long_body }

      it { expect(invalid_long_body).not_to be_valid }
    end
  end

  describe '#rating' do
    context 'when rating is short' do
      subject(:invalid_short_rating) { build :rating, :invalid_short_rating }

      it { expect(invalid_short_rating).not_to be_valid }
    end

    context 'when rating is long' do
      subject(:invalid_long_rating) { build :rating, :invalid_long_rating }

      it { expect(invalid_long_rating).not_to be_valid }
    end
  end
end
