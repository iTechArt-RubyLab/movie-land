module Notification
  class ReviewerService < ApplicationService
    def call
      movies = Movie
               .select('movies.name, release_date')
               .where(release_date: (Time.zone.today..1.week.after.utc))
      User.joins(:role).where(roles: { name: 'reviewer' }).find_each do |user|
        call_mailer(movies, user)
      end
    end

    private

    def call_mailer(movies, reviewer)
      ReviewerMailer.reviewer_notification(movies, reviewer).deliver_now
    end
  end
end
