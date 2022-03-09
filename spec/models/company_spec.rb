# == Schema Information
#
# Table name: companies
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_companies_on_name  (name) UNIQUE
#
require 'rails_helper'

RSpec.describe Company, type: :model do
  context 'with valid attributes' do
    subject(:company) { create :company }

    include_examples 'valid model'
  end

  context 'with invalid attributes' do
    context 'when name too long' do
      subject(:invalid_long_name) { build :company, :invalid_long_name }

      include_examples 'invalid model'
    end

    context 'when name too short' do
      subject(:invalid_short_name) { build :company, :invalid_short_name }

      include_examples 'invalid model'
    end
  end

  context 'with validations' do
    it { is_expected.to validate_uniqueness_of(:name).with_message('This company already exists') }
  end

  context 'with associations' do
    it { is_expected.to have_many(:companies_movies) }
    it { is_expected.to have_many(:movies) }
  end
end
