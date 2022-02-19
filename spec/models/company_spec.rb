require 'rails_helper'

RSpec.describe Company, type: :model do
  context 'with valid attributes' do
    subject(:company) { create :company }

    include_examples 'valid model'
  end

  describe '#name' do
    context 'when too long' do
      subject(:invalid_long_name) { build :company, :invalid_long_name }

      include_examples 'invalid model'
    end

    context 'when too short' do
      subject(:invalid_short_name) { build :company, :invalid_short_name }

      include_examples 'invalid model'
    end
  end
end
