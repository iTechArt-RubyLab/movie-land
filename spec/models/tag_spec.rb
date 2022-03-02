# == Schema Information
#
# Table name: tags
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_tags_on_name  (name) UNIQUE
#
require 'rails_helper'

RSpec.describe Tag, type: :model do
  subject(:tag) { create :tag }

  context 'with valid data' do
    it { expect(tag).to be_valid }
  end

  describe '#name' do
    context 'when name short' do
      subject(:invalid_short_name) { build :tag, :invalid_short_name }

      it { expect(invalid_short_name).not_to be_valid }
    end

    context 'when name long' do
      subject(:invalid_long_name) { build :tag, :invalid_long_name }

      it { expect(invalid_long_name).not_to be_valid }
    end
  end

  describe 'validations' do
    it { is_expected.to validate_uniqueness_of(:name).with_message('This tag already exists') }
  end

  context 'with associations' do
    it { should have_many(:movies_tags) }
    it { should have_many(:movies) }
  end
end
