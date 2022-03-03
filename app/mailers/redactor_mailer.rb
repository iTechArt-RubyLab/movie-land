class RedactorMailer < ApplicationMailer
  def redactor_notification(ratings, redactor)
    @ratings = ratings
    @redactor = redactor
    mail(to: @redactor.email, subject: 'Redactor Notification')
  end
end
