require 'rails_helper'

RSpec.describe CommentPolicy do
  subject { described_class.new(user, comment) }

  include_context 'with unique cleaner'

  let(:comment) { create :comment }

  context 'with admin access' do
    let(:user) { create :user, :admin }

    it { is_expected.to permit_actions(%i[create update destroy]) }
  end

  context 'with redactor access' do
    let(:user) { create :user, :redactor }

    it { is_expected.to permit_actions(%i[create update destroy]) }
  end

  context 'with reviewer access' do
    let(:user) { create :user, :reviewer }

    it { is_expected.to permit_actions(%i[create update destroy]) }
  end
end
