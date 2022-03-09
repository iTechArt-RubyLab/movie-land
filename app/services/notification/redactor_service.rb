module Notification
  class RedactorService< ApplicationService
    def call
      ratings = Rating
                .joins(:movie, :user)
                .select('ratings.rating, movies.name AS movie_name, users.name AS user_name')
                .where(created_at: Date.yesterday)
      User.joins(:role).where(roles: { name: 'redactor' }).find_each do |user|
        call_mailer(ratings, user)
      end
    end

    private

    def call_mailer(ratings, redactor)
      RedactorMailer.redactor_notification(ratings, redactor).deliver_now
    end
  end
end
