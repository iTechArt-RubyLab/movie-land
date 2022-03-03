class ReviewerNotificationWorker
  include Sidekiq::Worker
  queue_as :default

  def perform
    movies = Movie.where(release_date: (Time.zone.today..Time.zone.today + 7)).pluck(:name, :release_date)
    User.joins(:role).where(roles: { name: 'reviewer' }).find_each do |user|
      reviewer = user
      call_mailer(movies, reviewer)
    end
  end

  private

  def call_mailer(movies, reviewer)
    ReviewerMailer.reviewer_notification(movies, reviewer).deliver_now
  end
end
