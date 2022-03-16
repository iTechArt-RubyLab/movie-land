require 'rails_helper'

RSpec.describe UserPolicy do
  subject { described_class.new(user, user_obj) }

  let(:user_obj) { create :user }

  context 'with admin access' do
    let(:user) { create :user, :admin }

    let(:resolved_scope) do
      described_class::Scope.new(user, User.all).resolve
    end

    context 'when admin access to actions' do
      it { is_expected.to permit_actions(%i[index show update]) }
    end

    context 'when admin accessing a show user' do
      let(:users) { User.all }

      it { expect(resolved_scope).to eq(users) }
    end
  end

  context 'with redactor access' do
    let(:user) { create :user, :redactor }

    let(:resolved_scope) do
      described_class::Scope.new(user, User.all).resolve
    end

    context 'when redactor access to actions' do
      it { is_expected.to permit_actions(%i[index show]) }
      it { is_expected.to forbid_action(:update) }
    end

    context 'when redactor accessing a show user' do
      let(:not_locked_users) { User.where(locked_at: nil) }

      it { expect(resolved_scope).to eq(not_locked_users) }
    end
  end

  context 'with reviewer access' do
    let(:user) { create :user, :reviewer }

    let(:resolved_scope) do
      described_class::Scope.new(user, User.all).resolve
    end

    context 'when reviewer access to actions' do
      it { is_expected.to permit_actions(%i[index show]) }
      it { is_expected.to forbid_action(:update) }
    end

    context 'when reviewer accessing a show user' do
      let(:not_locked_users) { User.where(locked_at: nil) }

      it { expect(resolved_scope).to eq(not_locked_users) }
    end
  end
end
