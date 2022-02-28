require 'rails_helper'

RSpec.describe UserPolicy do
  subject { described_class.new(user, user_obj) }

  let(:user_obj) { create :user }

  context 'with admin access' do
    let(:user) { create :user, :admin }

    it { is_expected.to permit_actions(%i[index show update]) }
  end

  context 'with redactor access' do
    let(:user) { create :user, :redactor }

    it { is_expected.to permit_actions(%i[index show]) }
    it { is_expected.to forbid_action(:update) }
  end

  context 'with reviewer access' do
    let(:user) { create :user, :reviewer }

    it { is_expected.to permit_actions(%i[index show]) }
    it { is_expected.to forbid_action(:update) }
  end
end
