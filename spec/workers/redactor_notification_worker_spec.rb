require 'rails_helper'

RSpec.describe RedactorNotificationWorker, type: :model do
  subject(:redactor_notification) { described_class.new }

  context 'with perform' do
    let(:notification) { Notification::RedactorService.new.call }

    it { expect(redactor_notification.perform).to be(notification) }
  end
end
