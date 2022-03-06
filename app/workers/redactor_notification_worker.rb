class RedactorNotificationWorker
  include Sidekiq::Worker
  queue_as :default

  def perform
    Notification::RedactorService.new.call
  end
end
