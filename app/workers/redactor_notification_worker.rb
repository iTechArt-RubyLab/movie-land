class RedactorNotificationWorker
  include Sidekiq::Worker
  queue_as :default

  def perform
    Notification::RedactorService.call
  end
end
