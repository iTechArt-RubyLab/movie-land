require 'rails_helper'

RSpec.describe Company, type: :model do
  context 'with valid attributes' do
    subject(:company) { create :company }
    include_examples 'valid model'
  end
  describe '#title' do
    context 'when too long' do
      subject(:invalid_long_title) { build :company, :invalid_long_title }
      include_examples 'invalid model'
    end

    context 'when too short' do
      subject(:invalid_short_title) { build :company, :invalid_short_title }
      include_examples 'invalid model'
    end
  end
end
