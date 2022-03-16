require 'rails_helper'

RSpec.describe ApplicationPolicy do
  subject { described_class.new(user, record) }

  let(:resolved_scope) do
    described_class::Scope.new(user, Country.all).resolve
  end

  let(:record) { create :country }
  let(:user) { create :user }

  context 'with index' do
    it { is_expected.to forbid_action(%i[index]) }
  end

  context 'with show' do
    it { is_expected.to forbid_action(%i[show]) }
  end

  context 'with create' do
    it { is_expected.to forbid_action(%i[create]) }
  end

  context 'with update' do
    it { is_expected.to forbid_action(%i[update]) }
  end

  context 'with destroy' do
    it { is_expected.to forbid_action(%i[destroy]) }
  end

  context 'with accessing a create country' do
    let(:country) { Country.create(name: 'Russia') }

    it { expect(resolved_scope).to include(country) }
  end
end
