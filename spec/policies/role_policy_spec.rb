require 'rails_helper'

RSpec.describe RolePolicy do
  subject { described_class.new(user, role) }

  let(:role) { create :role }

  context 'with admin access' do
    let(:user) { create :user, :admin }

    it { is_expected.to permit_actions(%i[index show create update destroy]) }
  end

  context 'with redactor access' do
    let(:user) { create :user, :redactor }

    it { is_expected.to forbid_actions(%i[index show create update destroy]) }
  end

  context 'with reviewer access' do
    let(:user) { create :user, :reviewer }

    it { is_expected.to forbid_actions(%i[index show create update destroy]) }
  end
end
