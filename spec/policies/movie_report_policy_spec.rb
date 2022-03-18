require 'rails_helper'

RSpec.describe MovieReportPolicy do
  subject { described_class.new(user, movie) }

  include_context 'with unique cleaner'

  let(:movie) { create :movie }

  context 'with admin access' do
    let(:user) { create :user, :admin }

    it { is_expected.to permit_actions(%i[index show]) }
  end

  context 'with redactor access' do
    let(:user) { create :user, :redactor }

    it { is_expected.to permit_actions(%i[index show]) }
  end

  context 'with reviewer access' do
    let(:user) { create :user, :reviewer }

    it { is_expected.to forbid_actions(%i[index show]) }
  end
end
