class RedactorNotificationService
  def call
    ratings = Rating.where(created_at: Date.yesterday).joins(:movie, :user).pluck('rating', 'movies.name', 'users.name')
    User.joins(:role).where(roles: { name: 'redactor' }).find_each do |user|
      redactor = user
      call_mailer(ratings, redactor)
    end
  end

  private

  def call_mailer(ratings, redactor)
    RedactorMailer.redactor_notification(ratings, redactor).deliver_now
  end
end
