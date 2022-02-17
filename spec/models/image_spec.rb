require 'rails_helper'

RSpec.describe Image, type: :model do
  subject(:image) { create :image }

  context 'with valid attributes' do
    it { expect(image).to be_valid }
  end

  describe '#link' do
    context 'when link format is not correct' do
      subject(:invalid_format_link) { build :image, :invalid_format_link }
      it { expect(invalid_format_link).not_to be_valid }
    end
  end
end
