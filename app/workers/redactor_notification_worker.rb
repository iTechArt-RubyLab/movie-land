class RedactorNotificationWorker
  include Sidekiq::Worker
  queue_as :default

  def perform
    ratings = Rating.where(created_at: Date.yesterday).pluck(:rating, :movie_id, :user_id)
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
