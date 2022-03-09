require 'rails_helper'

RSpec.describe Category, type: :model do
  context 'with valid attributes' do
    subject(:category) { create :category }

    include_examples 'valid model'
  end

  context 'with invalid attributes' do
    context 'when name too long' do
      subject(:invalid_long_name) { build :category, :invalid_long_name }

      include_examples 'invalid model'
    end

    context 'when name too short' do
      subject(:invalid_short_name) { build :category, :invalid_short_name }

      include_examples 'invalid model'
    end
  end

  context 'with associations' do
    it { should belong_to(:award) }
  end
end