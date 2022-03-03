class ReviewerMailerPreview < ActionMailer::Preview
  def reviewer_notification
    movies = Movie.where(release_date: (Time.zone.today..Time.zone.today + 7)).pluck(:name, :release_date)
    reviewer = User.where(role_id: 3).first
    ReviewerMailer.reviewer_notification(movies, reviewer)
  end
end
