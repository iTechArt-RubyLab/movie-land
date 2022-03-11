require 'rails_helper'

RSpec.describe GuestUser, type: :model do
  subject(:guest_user) { described_class.new }

  context 'with accessable permission' do
    it 'returns access to read movie' do
      expect(guest_user.can_read_movie?).to be true
    end

    it 'returns access to read person' do
      expect(guest_user.can_read_person?).to be true
    end
  end

  context 'with inaccessable permission' do
    it 'returns no access to edit movie' do
      expect(guest_user.can_edit_movie?).to be false
    end

    it 'returns no access to edit person' do
      expect(guest_user.can_edit_person?).to be false
    end
  end
end
