class ReviewerNotificationService
  def call
    movies = Movie.where(release_date: (Time.zone.today..1.week.after.utc)).pluck(:name, :release_date)
    User.joins(:role).where(roles: { name: 'reviewer' }).find_each do |user|
      call_mailer(movies, user)
    end
  end

  private

  def call_mailer(movies, reviewer)
    ReviewerMailer.reviewer_notification(movies, reviewer).deliver_later
  end
end
