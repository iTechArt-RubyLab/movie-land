require 'rails_helper'

RSpec.describe RedactorMailer, type: :mailer do
  describe 'redactor notification' do
    let!(:ratings) do
      Rating
        .joins(:movie, :user)
        .select('ratings.rating, movies.name AS movie_name, users.name AS user_name')
    end
    let!(:redactor) { create :user, :redactor }
    let(:mail) { described_class.redactor_notification(ratings, redactor).deliver }

    it 'renders the subject' do
      expect(mail.subject).to eq('Redactor Notification')
    end

    it 'renders the redactor' do
      expect(mail.to).to eq([redactor.email])
    end

    it 'renders the body' do
      expect(mail.body.encoded).to match('Hello')
    end

    it 'sends an email' do
      described_class.redactor_notification(ratings, redactor).deliver
      expect(ActionMailer::Base.deliveries.count).to eq(1)
    end
  end
end
