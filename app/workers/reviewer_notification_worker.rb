class ReviewerNotificationWorker
  include Sidekiq::Worker
  queue_as :default

  def perform
    Notification::ReviewerService.call
  end
end
