require 'rails_helper'

RSpec.describe Award, type: :model do
  context 'with valid attributes' do
    subject(:award) { create :award }

    include_examples 'valid model'
  end

  describe '#name' do
    context 'when too long' do
      subject(:invalid_long_name) { build :award, :invalid_long_name }

      include_examples 'invalid model'
    end

    context 'when too short' do
      subject(:invalid_short_name) { build :award, :invalid_short_name }

      include_examples 'invalid model'
    end
  end

  describe '#nomination' do
    context 'when too long' do
      subject(:invalid_long_nomination) { build :award, :invalid_long_nomination }

      include_examples 'invalid model'
    end

    context 'when too short' do
      subject(:invalid_short_nomination) { build :award, :invalid_short_nomination }

      include_examples 'invalid model'
    end
  end
end
