# == Schema Information
#
# Table name: roles
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_roles_on_name  (name) UNIQUE
#
require 'rails_helper'

RSpec.describe Role, type: :model do
  context 'with valid attributes' do
    subject(:role) { create :role }

    include_examples 'valid model'
  end

  context 'with invalid attributes' do
    context 'when name too short' do
      subject(:invalid_short_name) { build :role, :invalid_short_name }

      include_examples 'invalid model'
    end

    context 'when name too long' do
      subject(:invalid_long_name) { build :role, :invalid_long_name }

      include_examples 'invalid model'
    end
  end

  context 'with validations' do
    it { should validate_uniqueness_of(:name).with_message('This role already exists') }
  end

  context 'with associations' do
    it { should have_one(:permission) }
    it { should have_many(:users) }
    it { should accept_nested_attributes_for(:permission) }
  end
end
