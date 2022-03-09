# == Schema Information
#
# Table name: categories
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  award_id   :bigint           not null
#
# Indexes
#
#  index_categories_on_award_id  (award_id)
#
# Foreign Keys
#
#  fk_rails_...  (award_id => awards.id)
#
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
