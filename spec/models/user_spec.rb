require 'rails_helper'

RSpec.describe User, type: :model do
  subject(:user) { create :user }

  context 'with valid attributes' do
    it { expect(user).to be_valid }
  end

  describe '#name' do
    context 'when name is short' do
      subject(:invalid_short_name) { build :user, :invalid_short_name }

      it { expect(invalid_short_name).not_to be_valid }
    end

    context 'when name is long' do
      subject(:invalid_long_name) { build :user, :invalid_long_name }

      it { expect(invalid_long_name).not_to be_valid }
    end
  end

  describe '#surname' do
    context 'when surname is short' do
      subject(:invalid_short_surname) { build :user, :invalid_short_surname }

      it { expect(invalid_short_surname).not_to be_valid }
    end

    context 'when surname is long' do
      subject(:invalid_long_surname) { build :user, :invalid_long_surname }

      it { expect(invalid_long_surname).not_to be_valid }
    end
  end

  describe '#username' do
    context 'when username is short' do
      subject(:invalid_short_username) { build :user, :invalid_short_username }

      it { expect(invalid_short_username).not_to be_valid }
    end

    context 'when username is long' do
      subject(:invalid_long_username) { build :user, :invalid_long_username }

      it { expect(invalid_long_username).not_to be_valid }
    end
  end
end
