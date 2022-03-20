require 'rails_helper'

RSpec.describe RatingPolicy do
  subject { described_class.new(user, rating) }

  include_context 'with unique cleaner'

  let(:rating) { create :rating }

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
