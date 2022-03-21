require 'rails_helper'

RSpec.describe SearchPolicy do
  subject { described_class.new(user, role) }

  let(:role) { create :role }

  context 'with admin access' do
    let(:user) { create :user, :admin }

    it { is_expected.to permit_action(%i[index]) }
  end

  context 'with redactor access' do
    let(:user) { create :user, :redactor }

    it { is_expected.to permit_action(%i[index]) }
  end

  context 'with reviewer access' do
    let(:user) { create :user, :reviewer }

    it { is_expected.to permit_action(%i[index]) }
  end
end
