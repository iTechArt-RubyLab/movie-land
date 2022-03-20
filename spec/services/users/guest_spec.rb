require 'rails_helper'

RSpec.describe Users::Guest, type: :model do
  subject(:guest_user) { described_class.new }

  context 'with accessable permission' do
    context 'when returns access to read movie' do
      it { expect(guest_user.can_read_movie?).to be true }
    end

    context 'when returns access to read person' do
      it { expect(guest_user.can_read_person?).to be true }
    end
  end

  context 'with inaccessable permission' do
    context 'when returns no access to edit movie' do
      it { expect(guest_user.can_edit_movie?).to be false }
    end

    context 'when returns no access to edit person' do
      it { expect(guest_user.can_edit_person?).to be false }
    end
  end
end
