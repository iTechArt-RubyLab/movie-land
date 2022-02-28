require 'rails_helper'

RSpec.describe TagPolicy do
  subject { described_class.new(user, tag) }

  let(:tag) { create :tag }

  context 'with admin access' do
    let(:user) { create :user, :admin }

    it { is_expected.to permit_action(:index) }
  end

  context 'with redactor access' do
    let(:user) { create :user, :redactor }

    it { is_expected.to permit_action(:index) }
  end

  context 'with reviewer access' do
    let(:user) { create :user, :reviewer }

    it { is_expected.to forbid_action(:index) }
  end
end
