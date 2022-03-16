require 'rails_helper'

RSpec.describe ReviewerNotificationWorker, type: :model do
  subject(:reviewer_notification) { described_class.new }

  context 'with perform' do
    let(:notification) { Notification::ReviewerService.new.call }

    it { expect(reviewer_notification.perform).to be(notification) }
  end
end
