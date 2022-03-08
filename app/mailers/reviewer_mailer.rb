class ReviewerMailer < ApplicationMailer
  def reviewer_notification(movies, reviewer)
    @reviewer = reviewer
    @movies = movies
    mail(to: @reviewer.email, subject: 'Reviewer Notification')
  end
end
