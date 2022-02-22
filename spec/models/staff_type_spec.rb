# == Schema Information
#
# Table name: staff_types
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_staff_types_on_name  (name) UNIQUE
#
require 'rails_helper'

RSpec.describe StaffType, type: :model do
  subject(:staff_type) { create :staff_type }

  context 'with valid data' do
    it { expect(staff_type).to be_valid }
  end

  describe '#name' do
    context 'when name short' do
      subject(:invalid_short_name) { build :staff_type, :invalid_short_name }

      it { expect(invalid_short_name).not_to be_valid }
    end

    context 'when name long' do
      subject(:invalid_long_name) { build :staff_type, :invalid_long_name }

      it { expect(invalid_long_name).not_to be_valid }
    end
  end

  describe 'validations' do
    it { is_expected.to validate_uniqueness_of(:name).with_message('This staff type already exists') }
  end
end
