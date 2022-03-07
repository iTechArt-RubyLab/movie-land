# == Schema Information
#
# Table name: awards
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  country_id :bigint           not null
#
# Indexes
#
#  index_awards_on_country_id  (country_id)
#  index_awards_on_name        (name) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (country_id => countries.id)
#
require 'rails_helper'

RSpec.describe Award, type: :model do
  context 'with valid attributes' do
    subject(:award) { create :award }

    include_examples 'valid model'
  end

  context 'with invalid attributes' do
    context 'when name too long' do
      subject(:invalid_long_name) { build :award, :invalid_long_name }

      include_examples 'invalid model'
    end

    context 'when name too short' do
      subject(:invalid_short_name) { build :award, :invalid_short_name }

      include_examples 'invalid model'
    end
  end

  context 'with validations' do
    let(:award_with_country) { create :award }

    it do
      expect(award_with_country).to validate_uniqueness_of(:name).with_message('This award already exists')
    end
  end

  context 'with associations' do
    it { should belong_to(:country) }
    it { should have_many(:movie_awards) }
  end
end
