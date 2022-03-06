require 'rails_helper'

RSpec.describe ReviewerMailer, type: :mailer do
  describe 'reviewer notification' do
    let!(:movies) do
      create_list(:movie, 20)
    end
    let!(:reviewer) { create :user, :reviewer }
    let(:mail) { described_class.reviewer_notification(movies, reviewer).deliver }

    it 'renders the subject' do
      expect(mail.subject).to eq('Reviewer Notification')
    end

    it 'renders the reviewer' do
      expect(mail.to).to eq([reviewer.email])
    end

    it 'renders the body' do
      expect(mail.body.encoded).to match('Hello')
    end

    it 'sends an email' do
      described_class.reviewer_notification(movies, reviewer).deliver
      expect(ActionMailer::Base.deliveries.count).to eq(1)
    end
  end
end
