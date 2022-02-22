# == Schema Information
#
# Table name: countries
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_countries_on_name  (name) UNIQUE
#
require 'rails_helper'

RSpec.describe Country, type: :model do
  subject(:country) { create :country }

  context 'with valid attributes' do
    it { expect(country).to be_valid }
  end

  describe '#name' do
    context 'when name is short' do
      subject(:invalid_short_name) { build :country, :invalid_short_name }

      it { expect(invalid_short_name).not_to be_valid }
    end

    context 'when name is long' do
      subject(:invalid_long_name) { build :country, :invalid_long_name }

      it { expect(invalid_long_name).not_to be_valid }
    end
  end

  describe 'validations' do
    it { is_expected.to validate_uniqueness_of(:name).with_message('This country already exists') }
  end
end
