require 'rails_helper'

RSpec.describe ViewListPolicy do
  subject { described_class.new(user, view_list) }

  include_context 'with unique cleaner'

  let(:view_list) { create :view_list }

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

    it { is_expected.to permit_actions(%i[index create update destroy]) }
  end
end
