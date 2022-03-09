require 'rails_helper'

RSpec.describe CategoryPolicy do
  subject { described_class.new(user, category) }

  let(:category) { create :category }

  context 'with admin access' do
    let(:user) { create :user, :admin }

    it { is_expected.to permit_actions(%i[index create update destroy]) }
  end

  context 'with redactor access' do
    let(:user) { create :user, :redactor }

    it { is_expected.to permit_actions(%i[index create update destroy]) }
  end

  context 'with reviewer access' do
    let(:user) { create :user, :reviewer }

    it { is_expected.to permit_actions(%i[index]) }
    it { is_expected.to forbid_actions(%i[create update destroy]) }
  end
end
