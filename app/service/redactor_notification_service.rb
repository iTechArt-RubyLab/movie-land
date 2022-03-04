class RedactorNotificationService
  def call
    ratings = Rating.where(created_at: Date.yesterday).joins(:movie, :user).pluck('rating', 'movies.name', 'users.name')
                    .map do |rating, movie_name, user_name|
      { rating: rating, 'movies.name': movie_name, 'users.name': user_name }
    end
    User.joins(:role).where(roles: { name: 'redactor' }).find_each do |user|
      call_mailer(ratings, user)
    end
  end

  private

  def call_mailer(ratings, redactor)
    RedactorMailer.redactor_notification(ratings, redactor).deliver_later
  end
end
