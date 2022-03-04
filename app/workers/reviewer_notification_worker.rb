class ReviewerNotificationWorker
  include Sidekiq::Worker
  queue_as :default

  def perform
    ReviewerNotificationService.new.call
  end
end
